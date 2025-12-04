require 'rails_helper'

RSpec.describe "roles/index", type: :view do
  before(:each) do
    assign(:roles, [
      Role.create!(name: 'administrador'),
      Role.create!(name: 'consolidador')
    ])
  end

  it "renders a list of roles" do
    render
    cell_selector = 'div>p'
  end
end
