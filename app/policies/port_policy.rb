class PortPolicy < ApplicationPolicy
  def index?
    user&.can?("ver puertos") || user&.can?("ports:read")
  end

  def show?
    user&.can?("ver puertos") || user&.can?("ports:read")
  end

  def create?
    user&.can?("crear puertos") || user&.can?("ports:create")
  end

  def update?
    user&.can?("editar puertos") || user&.can?("ports:update")
  end

  def destroy?
    user&.can?("eliminar puertos") || user&.can?("ports:delete")
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
