class RolePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      user&.can?("ver roles") || user&.can?("roles:read") ? scope.all : scope.none
    end
  end

  def index?
    user&.can?("ver roles") || user&.can?("roles:read")
  end

  def show?
    user&.can?("ver roles") || user&.can?("roles:read")
  end

  def create?
    user&.can?("crear roles") || user&.can?("roles:create")
  end

  def new?
    user&.can?("crear roles") || user&.can?("roles:create")
  end

  def update?
    user&.can?("editar roles") || user&.can?("roles:update")
  end

  def edit?
    user&.can?("editar roles") || user&.can?("roles:update")
  end

  def destroy?
    user&.can?("eliminar roles") || user&.can?("roles:delete")
  end
end
