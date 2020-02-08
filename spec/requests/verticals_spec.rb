# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Verticals", type: :request do
  let!(:business) { create(:vertical, :valid, name: "Business") }
  let!(:weight_loss) { create(:vertical, :valid, name: "Weight Loss") }

  describe "GET /v1/verticals" do
    context "authenticated requests" do
      it "sends data of all verticals" do
        get "/v1/verticals"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["count"]).to eq(2)
      end
    end
  end

  describe "POST /v1/verticals" do
    context "name is missing in params" do
      subject do
        post "/v1/verticals",
             params: { vertical: { name: "" } }
      end

      it "does not add vertical to the database" do
        expect { subject }.not_to change(Vertical, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end
    end

    context "duplicate name" do
      let!(:business) { create(:vertical, :valid, name: "Business") }

      subject do
        post "/v1/verticals",
             params: { vertical: { name: "Business" } }
      end

      it "does not add vertical to the database" do
        expect { subject }.not_to change(Vertical, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("has already been taken")
      end
    end

    context "name is given and is unique" do
      subject do
        post "/v1/verticals",
             params: { vertical: { name: "Social Media" } }
      end

      it "adds record to the database" do
        expect { subject }.to change(Vertical, :count).by(1)
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)["vertical"]["name"]).to eq("Social Media")
      end
    end
  end
end
