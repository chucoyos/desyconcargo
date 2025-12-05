class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      user&.can?("ver usuarios") || user&.can?("users:read") ? scope.all : scope.none
    end
  end

  def index?
    user&.can?("ver usuarios") || user&.can?("users:read")
  end

  def show?
    user&.can?("ver usuarios") || user&.can?("users:read")
  end

  def create?
    user&.can?("crear usuarios") || user&.can?("users:create")
  end

  def new?
    user&.can?("crear usuarios") || user&.can?("users:create")
  end

  def update?
    user&.can?("editar usuarios") || user&.can?("users:update")
  end

  def edit?
    user&.can?("editar usuarios") || user&.can?("users:update")
  end

  def destroy?
    user&.can?("eliminar usuarios") || user&.can?("users:delete")
  end

  def deactivate?
    user&.can?("desactivar usuarios") || user&.can?("users:deactivate")
  end
end
