require 'rails_helper'

RSpec.describe "ports/edit", type: :view do
  let(:port) {
    Port.create!(
      name: "MyString",
      country: "US",
      uncode: "ABCDE"
    )
  }

  before(:each) do
    assign(:port, port)
  end

  it "renders the edit port form" do
    render

    assert_select "form[action=?][method=?]", port_path(port), "post" do
      assert_select "input[name=?]", "port[name]"

      assert_select "select[name=?]", "port[country]"

      assert_select "input[name=?]", "port[uncode]"
    end
  end
end
