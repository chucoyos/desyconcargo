require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    let(:valid_attributes) do
      {
        name: 'Dirección Principal',
        country: 'MX',
        postal_code: '01000',
        state: 'Ciudad de México',
        municipality: 'Cuauhtémoc',
        colony: 'Centro Histórico',
        street: 'Calle 5 de Mayo',
        exterior_number: '123',
        interior_number: '4A',
        email: 'contacto@empresa.com'
      }
    end

    it 'is valid with valid attributes' do
      address = Address.new(valid_attributes)
      expect(address).to be_valid
    end

    it 'validates presence of name' do
      address = Address.new(valid_attributes.merge(name: nil))
      expect(address).not_to be_valid
      expect(address.errors[:name]).to include("no puede estar en blanco")
    end

    it 'validates presence of country' do
      address = Address.new(valid_attributes.merge(country: nil))
      expect(address).not_to be_valid
      expect(address.errors[:country]).to include("no puede estar en blanco")
    end

    it 'validates country code length' do
      address = Address.new(valid_attributes.merge(country: 'MEX'))
      expect(address).not_to be_valid
      expect(address.errors[:country]).to include("longitud errónea (debe ser de 2 caracteres)")
    end

    it 'validates country code is valid ISO 3166-1 alpha-2' do
      address = Address.new(valid_attributes.merge(country: 'XX'))
      expect(address).not_to be_valid
      expect(address.errors[:country]).to include("debe ser un código de país válido (ISO 3166-1 alpha-2)")
    end

    it 'accepts valid country codes' do
      address = Address.new(valid_attributes.merge(country: 'US'))
      expect(address).to be_valid
    end

    it 'validates presence of postal_code' do
      address = Address.new(valid_attributes.merge(postal_code: nil))
      expect(address).not_to be_valid
      expect(address.errors[:postal_code]).to include("no puede estar en blanco")
    end

    it 'validates postal_code format (5 digits)' do
      address = Address.new(valid_attributes.merge(postal_code: '1234'))
      expect(address).not_to be_valid
      expect(address.errors[:postal_code]).to include("debe tener 5 dígitos")
    end

    it 'accepts valid 5-digit postal codes' do
      address = Address.new(valid_attributes.merge(postal_code: '12345'))
      expect(address).to be_valid
    end

    it 'validates presence of state' do
      address = Address.new(valid_attributes.merge(state: nil))
      expect(address).not_to be_valid
      expect(address.errors[:state]).to include("no puede estar en blanco")
    end

    it 'validates email format when present' do
      address = Address.new(valid_attributes.merge(email: 'invalid-email'))
      expect(address).not_to be_valid
      expect(address.errors[:email]).to be_present
    end

    it 'allows blank email' do
      address = Address.new(valid_attributes.merge(email: nil))
      expect(address).to be_valid
    end

    it 'accepts valid email' do
      address = Address.new(valid_attributes.merge(email: 'test@example.com'))
      expect(address).to be_valid
    end

    it 'allows optional fields to be blank' do
      minimal_address = Address.new(
        name: 'Dirección Principal',
        country: 'MX',
        postal_code: '01000',
        state: 'Ciudad de México',
        email: 'test@example.com'
      )
      expect(minimal_address).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to addressable polymorphically' do
      association = Address.reflect_on_association(:addressable)
      expect(association).to_not be_nil
      expect(association.options[:polymorphic]).to be_truthy
      expect(association.options[:optional]).to be_truthy
    end
  end
end
