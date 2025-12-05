class FiscalProfile < ApplicationRecord
  validates :razon_social, presence: true
  validates :rfc, presence: true, uniqueness: true
  validates :regimen, presence: true
  validates :uso_cfdi, presence: true
  validates :forma_pago, presence: true
  validates :metodo_pago, presence: true

  validate :rfc_format

  private

  def rfc_format
    return if rfc.blank?

    # RFC formats: 12 or 13 characters
    # Personas morales: 3 letters + 6 digits + 3 alphanumeric = 12 chars
    # Personas físicas: 4 letters + 6 digits + 3 alphanumeric = 13 chars
    unless rfc.match?(/\A[A-Z]{3,4}[0-9]{6}[A-Z0-9]{3}\z/)
      errors.add(:rfc, "debe tener un formato válido (12 o 13 caracteres)")
    end
  end
end
