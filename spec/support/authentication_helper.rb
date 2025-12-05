module AuthenticationHelper
  def sign_in_admin_for_request
    admin_role = Role.find_or_create_by!(name: 'Administrador')
    admin_user = User.find_or_create_by!(email: 'admin@test.com') do |user|
      user.password = 'password123'
      user.password_confirmation = 'password123'
      user.role = admin_role
    end

    # Ensure admin has all permissions
    Permission.all.each do |permission|
      RolePermission.find_or_create_by!(role: admin_role, permission: permission)
    end

    login_as admin_user
  end

  def sign_in_admin_for_controller
    admin_role = Role.find_or_create_by!(name: 'Administrador')
    admin_user = User.find_or_create_by!(email: 'admin@test.com') do |user|
      user.password = 'password123'
      user.password_confirmation = 'password123'
      user.role = admin_role
    end

    # Ensure admin has all permissions
    Permission.all.each do |permission|
      RolePermission.find_or_create_by!(role: admin_role, permission: permission)
    end

    sign_in admin_user
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :request

  config.before(:each, type: :request) do
    sign_in_admin_for_request
  end
end
