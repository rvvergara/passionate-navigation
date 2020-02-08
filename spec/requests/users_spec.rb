# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "POST /v1/users" do
    context "email not given" do
      subject do
        post "/v1/users",
             params: { user: { email: "", password: "password" } }
      end

      it "has a response of 422" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["email"]).to include("can't be blank")
      end
    end

    context "email and password given" do
      subject do
        post "/v1/users",
             params: { user: attributes_for(:user, email: "ryto@gmail.com") }
      end

      it "has a response status of created" do
        subject
        expect(response).to have_http_status(:created)
      end

      it "responds w/ user data and token" do
        subject
        json_response = JSON.parse(response.body)

        expect(json_response["data"]["email"]).to eq("ryto@gmail.com")
        expect(json_response["token"]).to_not be("")
      end
    end
  end
end
