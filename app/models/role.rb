class Role < ApplicationRecord
  has_many :users, dependent: :restrict_with_error
  has_many :role_permissions, dependent: :destroy
  has_many :permissions, through: :role_permissions

  validates :name, presence: true, uniqueness: true

  # Roles para agencia aduanal
  ADMINISTRADOR = "administrador".freeze
  AGENTE_ADUANAL = "agente_aduanal".freeze
  CONSOLIDADOR = "consolidador".freeze
  ALMACEN = "almacen".freeze
  INACTIVO = "inactivo".freeze

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

  def self.inactivo
    find_by(name: INACTIVO)
  end

  # Verificar si el rol tiene un permiso específico
  def has_permission?(permission_name)
    permissions.exists?(name: permission_name)
  end

  # Obtener todos los nombres de permisos del rol
  def permission_names
    permissions.pluck(:name)
  end
end
