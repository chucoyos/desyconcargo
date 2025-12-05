require 'rails_helper'

RSpec.describe "roles/index", type: :view do
  before(:each) do
    assign(:roles, [
      Role.find_or_create_by!(name: 'Test Admin'),
      Role.find_or_create_by!(name: 'Test User')
    ])
  end

  it "renders a list of roles" do
    render
    cell_selector = 'div>p'
  end
end
