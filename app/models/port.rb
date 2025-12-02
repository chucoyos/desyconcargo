class Port < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :country, presence: true, inclusion: { in: ISO3166::Country.codes }
  validates :uncode, presence: true, uniqueness: true, format: { with: /\A[A-Z]{5}\z/, message: "debe tener exactamente 5 letras mayúsculas" }

  # Helper method to get country name
  def country_name
    ISO3166::Country[country]&.common_name || ISO3166::Country[country]&.iso_short_name
  end

  # Helper method to get country flag
  def country_flag
    ISO3166::Country[country]&.emoji_flag
  end
end
