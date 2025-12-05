class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :entity, optional: true
  belongs_to :role, optional: true

  # Métodos helper para verificar roles
  def administrador?
    role&.name == Role::ADMINISTRADOR
  end

  def agente_aduanal?
    role&.name == Role::AGENTE_ADUANAL
  end

  def consolidador?
    role&.name == Role::CONSOLIDADOR
  end

  def almacen?
    role&.name == Role::ALMACEN
  end

  # Método para verificar si el usuario tiene un rol específico
  def has_role?(role_name)
    role&.name == role_name
  end

  def inactivo?
    role&.name == Role::INACTIVO
  end

  # Verificar si el usuario tiene un permiso específico
  def has_permission?(permission_name)
    return true if administrador? # Administradores tienen todos los permisos
    return false if inactivo? # Usuarios inactivos no tienen permisos
    role&.has_permission?(permission_name) || false
  end

  # Verificar si el usuario puede realizar una acción específica
  def can?(action)
    has_permission?(action)
  end

  # Asignar rol por defecto si no tiene uno
  after_create :assign_default_role

  private

  def assign_default_role
    self.role ||= Role.inactivo || Role.first
  end
end
