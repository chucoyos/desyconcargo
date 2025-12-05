class VesselPolicy < ApplicationPolicy
  def index?
    user&.can?("ver buques") || user&.can?("vessels:read")
  end

  def show?
    user&.can?("ver buques") || user&.can?("vessels:read")
  end

  def create?
    user&.can?("crear buques") || user&.can?("vessels:create")
  end

  def update?
    user&.can?("editar buques") || user&.can?("vessels:update")
  end

  def destroy?
    user&.can?("eliminar buques") || user&.can?("vessels:delete")
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
