require 'rails_helper'

RSpec.describe "ports/index", type: :view do
  before(:each) do
    ports = [
      Port.create!(
        name: "Port One",
        country: "US",
        uncode: "ABCDE"
      ),
      Port.create!(
        name: "Port Two",
        country: "ES",
        uncode: "FGHIJ"
      )
    ]
    assign(:ports, Kaminari.paginate_array(ports).page(1))
  end

  it "renders a list of ports" do
    render
    assert_select "h3", text: "Port One", count: 1
    assert_select "h3", text: "Port Two", count: 1
    assert_select "p", text: /United States • ABCDE/, count: 1
    assert_select "p", text: /Spain • FGHIJ/, count: 1
  end
end
