require 'rails_helper'

RSpec.describe "ports/show", type: :view do
  before(:each) do
    assign(:port, Port.create!(
      name: "Port Show",
      country: "US",
      uncode: "ABCDE"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Puerto: Port Show/)
    expect(rendered).to include("Editar")
    expect(rendered).to include("Eliminar")
    expect(rendered).to include("Nuevo Puerto")
  end
end
