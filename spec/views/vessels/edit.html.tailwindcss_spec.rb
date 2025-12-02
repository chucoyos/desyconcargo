require 'rails_helper'

RSpec.describe "vessels/edit", type: :view do
  let(:vessel) {
    Vessel.create!(
      name: "MyString",
      shipping_line: nil
    )
  }

  before(:each) do
    assign(:vessel, vessel)
  end

  it "renders the edit vessel form" do
    render

    assert_select "form[action=?][method=?]", vessel_path(vessel), "post" do

      assert_select "input[name=?]", "vessel[name]"

      assert_select "input[name=?]", "vessel[shipping_line_id]"
    end
  end
end
