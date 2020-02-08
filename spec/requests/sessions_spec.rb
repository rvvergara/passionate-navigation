# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "POST /v1/sessions" do
    let(:mike) { create(:user) }

    context "correct credentials" do
      subject do
        post "/v1/sessions",
             params: { email: mike.email, password: "password" }
      end

      it "has a response of ok" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "renders a json data of the user with token" do
        subject
        json_response = JSON.parse(response.body)

        expect(json_response["data"]["email"]).to eq(mike.email)
        expect(json_response["token"]).to_not be("")
      end
    end

    context "incorrect credentials" do
      subject do
        post "/v1/sessions",
             params: { email: mike.email, password: "pass" }
      end

      it "has a response status of unauthorized" do
        subject
        expect(response).to have_http_status(401)
      end

      it "renders an error message" do
        subject
        expect(JSON.parse(response.body)["message"]).to eq("Invalid credentials")
      end
    end
  end
end
