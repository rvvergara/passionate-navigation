# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Verticals", type: :request do
  describe "GET /verticals" do
    let!(:business) { create(:vertical, :valid, name: "Business") }
    let!(:weight_loss) { create(:vertical, :valid, name: "Weight Loss") }
    context "authenticated requests" do
      it "sends data of all verticals" do
        get "/v1/verticals"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["count"]).to eq(2)
      end
    end
  end
end
