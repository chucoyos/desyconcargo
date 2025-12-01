require 'rails_helper'

RSpec.describe "ShippingLines", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/shipping_lines/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/shipping_lines/show"
      expect(response).to have_http_status(:success)
    end
  end
end
