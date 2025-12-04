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

  # Asignar rol por defecto si no tiene uno
  after_create :assign_default_role

  private

  def assign_default_role
    self.role ||= Role.almacen || Role.first
  end
end
