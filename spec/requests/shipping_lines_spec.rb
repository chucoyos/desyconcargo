require 'rails_helper'

RSpec.describe "ShippingLines", type: :request do
  describe "GET /shipping_lines" do
    it "returns http success" do
      get shipping_lines_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /shipping_lines/:id" do
    let!(:shipping_line) { ShippingLine.create!(name: "Test Line") }

    it "returns http success" do
      get shipping_line_path(shipping_line)
      expect(response).to have_http_status(:success)
    end
  end
end
