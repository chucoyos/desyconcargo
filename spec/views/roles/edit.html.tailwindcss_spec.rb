require 'rails_helper'

RSpec.describe "roles/edit", type: :view do
  let(:role) {
    Role.find_or_create_by!(name: 'Test Role')
  }

  before(:each) do
    assign(:role, role)
  end

  it "renders the edit role form" do
    render

    assert_select "form[action=?][method=?]", role_path(role), "post" do
    end
  end
end
