class ShippingLinePolicy < ApplicationPolicy
  def index?
    user&.can?("ver líneas navieras") || user&.can?("shipping_lines:read")
  end

  def show?
    user&.can?("ver líneas navieras") || user&.can?("shipping_lines:read")
  end

  def new?
    user&.can?("crear líneas navieras") || user&.can?("shipping_lines:create")
  end

  def create?
    user&.can?("crear líneas navieras") || user&.can?("shipping_lines:create")
  end

  def update?
    user&.can?("editar líneas navieras") || user&.can?("shipping_lines:update")
  end

  def destroy?
    user&.can?("eliminar líneas navieras") || user&.can?("shipping_lines:delete")
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
