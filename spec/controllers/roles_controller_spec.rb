require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:admin_role) { Role.create!(name: 'administrador') }
  let(:regular_role) { Role.create!(name: 'consolidador') }

  before do
    admin_role
    regular_role
  end

  describe "GET #index" do
    context "when user is admin" do
      let(:admin_user) { User.create!(email: 'admin@example.com', password: 'password', role_id: admin_role.id) }

      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(admin_user)
        get :index
      end

      it "returns success" do
        expect(response).to be_successful
      end

      it "assigns all roles to @roles" do
        expect(assigns(:roles)).to match_array([ admin_role, regular_role ])
      end
    end

    context "when user is not admin" do
      let(:regular_user) { User.create!(email: 'user@example.com', password: 'password', role_id: regular_role.id) }

      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(regular_user)
        get :index
      end

      it "returns success" do
        expect(response).to be_successful
      end

      it "assigns empty array to @roles" do
        expect(assigns(:roles)).to be_empty
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
