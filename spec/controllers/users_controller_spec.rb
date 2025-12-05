require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:admin_role) { Role.find_or_create_by!(name: 'administrador') }
  let(:admin_user) { User.create!(email: 'admin@example.com', password: 'password123', role: admin_role) }
  let(:user_role) { Role.find_or_create_by!(name: 'agente_aduanal') }
  let(:user_params) do
    {
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123',
      role_id: user_role.id
    }
  end

  before do
    allow(controller).to receive(:current_user).and_return(admin_user)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post :create, params: { user: user_params }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, params: { user: user_params }
        expect(response).to redirect_to(User.last)
      end

      it "sets the password for the new user" do
        post :create, params: { user: user_params }
        created_user = User.last
        expect(created_user.valid_password?('password123')).to be_truthy
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { user_params.merge(email: '') }

      it "does not create a new User" do
        expect {
          post :create, params: { user: user_params.merge(email: '') }
        }.to_not change(User, :count)
      end

      it "renders the new template" do
        post :create, params: { user: user_params.merge(email: '') }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    let(:user) { User.create!(email: 'user@example.com', password: 'password123', role: user_role) }

    it "returns a success response" do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    let(:user) { User.create!(email: 'user@example.com', password: 'password123', role: user_role) }

    it "returns a success response" do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    let(:user) { User.create!(email: 'user@example.com', password: 'password123', role: user_role) }
    let(:new_attributes) { { email: 'updated@example.com' } }
    let(:password_attributes) { { password: 'newpassword123', password_confirmation: 'newpassword123' } }

    context "with valid parameters" do
      it "updates the requested user" do
        patch :update, params: { id: user.id, user: new_attributes }
        user.reload
        expect(user.email).to eq('updated@example.com')
      end

      it "redirects to the user" do
        patch :update, params: { id: user.id, user: new_attributes }
        expect(response).to redirect_to(user)
      end

      it "updates the password when provided" do
        patch :update, params: { id: user.id, user: password_attributes }
        user.reload
        expect(user.valid_password?('newpassword123')).to be_truthy
      end

      it "does not update password when blank" do
        original_password = user.encrypted_password
        patch :update, params: { id: user.id, user: { password: '', password_confirmation: '' } }
        user.reload
        expect(user.encrypted_password).to eq(original_password)
      end
    end

    context "with invalid parameters" do
      it "renders the edit template" do
        patch :update, params: { id: user.id, user: { email: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#user_params" do
    let(:admin_user) { User.create!(email: 'admin@example.com', password: 'password123', role: admin_role) }

    before do
      allow(controller).to receive(:current_user).and_return(admin_user)
    end

    it "filters out blank password parameters" do
      params = ActionController::Parameters.new(
        user: {
          email: 'test@example.com',
          password: '',
          password_confirmation: '',
          role_id: user_role.id
        }
      )
      allow(controller).to receive(:params).and_return(params)

      filtered_params = controller.send(:user_params)
      expect(filtered_params.to_h).to eq({
        'email' => 'test@example.com',
        'role_id' => user_role.id
      })
    end

    it "includes password parameters when present" do
      params = ActionController::Parameters.new(
        user: {
          email: 'test@example.com',
          password: 'newpassword123',
          password_confirmation: 'newpassword123',
          role_id: user_role.id
        }
      )
      allow(controller).to receive(:params).and_return(params)

      filtered_params = controller.send(:user_params)
      expect(filtered_params.to_h).to eq({
        'email' => 'test@example.com',
        'password' => 'newpassword123',
        'password_confirmation' => 'newpassword123',
        'role_id' => user_role.id
      })
    end
  end
end
