require 'rails_helper'

RSpec.describe "vessels/index", type: :view do
  before(:each) do
    shipping_line = ShippingLine.create!(name: "Test Line")
    vessels = [
      Vessel.create!(
        name: "Vessel One",
        shipping_line: shipping_line
      ),
      Vessel.create!(
        name: "Vessel Two",
        shipping_line: shipping_line
      )
    ]
    assign(:vessels, Kaminari.paginate_array(vessels).page(1))
  end

  it "renders a list of vessels" do
    render
    assert_select "table tbody tr", count: 2
    assert_select "table tbody tr td", text: "Vessel One"
    assert_select "table tbody tr td", text: "Vessel Two"
  end
end
