class Address < ApplicationRecord
  # Associations
  belongs_to :addressable, polymorphic: true, optional: true

  # Validations
  validates :name, presence: true
  validates :country, presence: true, length: { is: 2 }
  validates :postal_code, presence: true, format: { with: /\A\d{5}\z/, message: "debe tener 5 dígitos" }
  validates :state, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  # Custom validations
  validate :country_code_valid

  private

  def country_code_valid
    return if country.blank?

    unless ISO3166::Country[country.upcase]
      errors.add(:country, "debe ser un código de país válido (ISO 3166-1 alpha-2)")
    end
  end
end
