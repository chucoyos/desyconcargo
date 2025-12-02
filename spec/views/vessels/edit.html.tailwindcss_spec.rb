require 'rails_helper'

RSpec.describe "vessels/edit", type: :view do
  let(:vessel) {
    shipping_line = ShippingLine.create!(name: "Test Line")
    Vessel.create!(
      name: "MyString",
      shipping_line: shipping_line
    )
  }

  before(:each) do
    assign(:vessel, vessel)
  end

  it "renders the edit vessel form" do
    render

    assert_select "form[action=?][method=?]", vessel_path(vessel), "post" do
      assert_select "input[name=?]", "vessel[name]"

      assert_select "select[name=?]", "vessel[shipping_line_id]"
    end
  end
end
