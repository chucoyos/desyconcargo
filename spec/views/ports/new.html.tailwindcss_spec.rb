require 'rails_helper'

RSpec.describe "ports/new", type: :view do
  before(:each) do
    assign(:port, Port.new(
      name: "MyString",
      country: "US",
      uncode: "ABCDE"
    ))
  end

  it "renders new port form" do
    render

    assert_select "form[action=?][method=?]", ports_path, "post" do
      assert_select "input[name=?]", "port[name]"

      assert_select "select[name=?]", "port[country]"

      assert_select "input[name=?]", "port[uncode]"
    end
  end
end
