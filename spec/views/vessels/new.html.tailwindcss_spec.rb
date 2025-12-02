require 'rails_helper'

RSpec.describe "vessels/new", type: :view do
  before(:each) do
    assign(:vessel, Vessel.new(
      name: "MyString",
      shipping_line: nil
    ))
  end

  it "renders new vessel form" do
    render

    assert_select "form[action=?][method=?]", vessels_path, "post" do

      assert_select "input[name=?]", "vessel[name]"

      assert_select "input[name=?]", "vessel[shipping_line_id]"
    end
  end
end
