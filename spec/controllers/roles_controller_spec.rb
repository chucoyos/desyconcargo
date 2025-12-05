require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:admin_role) { Role.find_or_create_by!(name: 'administrador') }
  let(:regular_role) do
    role = Role.find_or_create_by!(name: 'consolidador')
    ver_roles_permission = Permission.find_or_create_by!(name: 'ver roles')
    RolePermission.find_or_create_by!(role: role, permission: ver_roles_permission)
    role
  end

  before do
    admin_role
    regular_role
  end

  describe "GET #index" do
    context "when user is admin" do
      let(:admin_user) { User.create!(email: 'admin@example.com', password: 'password', role_id: admin_role.id) }

      before do
        allow(controller).to receive(:current_user).and_return(admin_user)
        get :index
      end

      it "returns success" do
        expect(response).to be_successful
      end

      it "assigns all roles to @roles" do
        expect(assigns(:roles)).to match_array(Role.all)
      end
    end

    context "when user is not admin" do
      let(:regular_user) { User.create!(email: 'user@example.com', password: 'password', role_id: regular_role.id) }

      before do
        allow(controller).to receive(:current_user).and_return(regular_user)
        get :index
      end

      it "returns success" do
        expect(response).to be_successful
      end

      it "assigns all roles to @roles" do
        expect(assigns(:roles)).to match_array(Role.all)
      end
    end

    context "when user is not authenticated" do
      it "returns success" do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
