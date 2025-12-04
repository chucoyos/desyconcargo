class Role < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true

  # Roles para agencia aduanal
  ADMINISTRADOR = "administrador".freeze
  AGENTE_ADUANAL = "agente_aduanal".freeze
  CONSOLIDADOR = "consolidador".freeze
  ALMACEN = "almacen".freeze

  def self.administrador
    find_by(name: ADMINISTRADOR)
  end

  def self.agente_aduanal
    find_by(name: AGENTE_ADUANAL)
  end

  def self.consolidador
    find_by(name: CONSOLIDADOR)
  end

  def self.almacen
    find_by(name: ALMACEN)
  end
end
