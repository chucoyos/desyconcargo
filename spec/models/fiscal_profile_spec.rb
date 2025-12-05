require 'rails_helper'

RSpec.describe FiscalProfile, type: :model do
  describe 'validations' do
    let(:valid_attributes) do
      {
        razon_social: 'Empresa Ejemplo SA de CV',
        rfc: 'EXE123456789',
        regimen: '601',
        uso_cfdi: 'G01',
        forma_pago: '01',
        metodo_pago: 'PUE'
      }
    end

    it 'is valid with valid attributes' do
      fiscal_profile = FiscalProfile.new(valid_attributes)
      expect(fiscal_profile).to be_valid
    end

    it 'validates presence of razon_social' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(razon_social: nil))
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:razon_social]).to include("no puede estar en blanco")
    end

    it 'validates presence of rfc' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(rfc: nil))
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:rfc]).to include("no puede estar en blanco")
    end

    it 'validates uniqueness of rfc' do
      FiscalProfile.create!(valid_attributes)
      fiscal_profile = FiscalProfile.new(valid_attributes)
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:rfc]).to include("ya está en uso")
    end

    it 'validates RFC format for persona moral (12 characters)' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(rfc: 'EXE123456789'))
      expect(fiscal_profile).to be_valid
    end

    it 'validates RFC format for persona física (13 characters)' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(rfc: 'ABCD123456789'))
      expect(fiscal_profile).to be_valid
    end

    it 'invalidates RFC with wrong format' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(rfc: 'INVALIDRFC'))
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:rfc]).to include("debe tener un formato válido (12 o 13 caracteres)")
    end

    it 'validates presence of regimen' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(regimen: nil))
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:regimen]).to include("no puede estar en blanco")
    end

    it 'validates presence of uso_cfdi' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(uso_cfdi: nil))
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:uso_cfdi]).to include("no puede estar en blanco")
    end

    it 'validates presence of forma_pago' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(forma_pago: nil))
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:forma_pago]).to include("no puede estar en blanco")
    end

    it 'validates presence of metodo_pago' do
      fiscal_profile = FiscalProfile.new(valid_attributes.merge(metodo_pago: nil))
      expect(fiscal_profile).not_to be_valid
      expect(fiscal_profile.errors[:metodo_pago]).to include("no puede estar en blanco")
    end
  end
end
