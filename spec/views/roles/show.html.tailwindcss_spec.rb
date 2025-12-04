require 'rails_helper'

RSpec.describe "roles/show", type: :view do
  before(:each) do
    assign(:role, Role.create!(name: 'administrador'))
  end

  it "renders attributes in <p>" do
    render
  end
end
