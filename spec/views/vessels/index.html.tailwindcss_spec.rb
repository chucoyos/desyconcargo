require 'rails_helper'

RSpec.describe "vessels/index", type: :view do
  before(:each) do
    assign(:vessels, [
      Vessel.create!(
        name: "Name",
        shipping_line: nil
      ),
      Vessel.create!(
        name: "Name",
        shipping_line: nil
      )
    ])
  end

  it "renders a list of vessels" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
