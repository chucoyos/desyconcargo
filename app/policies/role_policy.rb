class RolePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      # Solo administradores pueden ver todos los roles
      user&.administrador? ? scope.all : scope.none
    end
  end

  def index?
    user&.administrador?
  end

  def show?
    user&.administrador?
  end

  def create?
    user&.administrador?
  end

  def new?
    user&.administrador?
  end

  def update?
    user&.administrador?
  end

  def edit?
    user&.administrador?
  end

  def destroy?
    user&.administrador?
  end
end
