require 'rails_helper'

RSpec.describe "roles/show", type: :view do
  before(:each) do
    assign(:role, Role.find_or_create_by!(name: 'Test Role'))
  end

  it "renders attributes in <p>" do
    render
  end
end
