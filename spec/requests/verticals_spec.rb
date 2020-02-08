# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Verticals", type: :request do
  let!(:business) { create(:vertical, :valid, name: "Business") }
  let!(:weight_loss) { create(:vertical, :valid, name: "Weight Loss") }
  let(:mike) { create(:user) }
  let!(:login) { login_as(mike) }

  describe "unauthenticated requests" do
    it {
      get "/v1/verticals"
      expect(response).to have_http_status(401)
    }
    it {
      post "/v1/verticals",
           params: { vertical: { name: "Business" } }
      expect(response).to have_http_status(401)
    }
    it {
      put "/v1/verticals/#{weight_loss.id}",
          params: { vertical: { name: "Weight Management" } }
      expect(response).to have_http_status(401)
    }
    it {
      delete "/v1/verticals/#{weight_loss.id}"
      expect(response).to have_http_status(401)
    }
  end

  describe "GET /v1/verticals" do
    context "authenticated requests" do
      it "sends data of all verticals" do
        get "/v1/verticals",
            headers: authorization_header
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["count"]).to eq(2)
      end
    end
  end

  describe "POST /v1/verticals" do
    context "name is missing in params" do
      subject do
        post "/v1/verticals",
             params: { vertical: { name: "" } },
             headers: authorization_header
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
             params: { vertical: { name: "Business" } },
             headers: authorization_header
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
             params: { vertical: { name: "Social Media" } },
             headers: authorization_header
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

  describe "PUT /v1/verticals/:id" do
    let!(:jobs) { create(:vertical, :valid, name: "Jobs") }

    context "vertical id in params is wrong" do
      subject do
        put "/v1/verticals/#{jobs.id + 'ee'}",
            params: { vertical: { name: "Employment" } },
            headers: authorization_header
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(404)
      end
    end

    context "name is missing in params" do
      subject do
        put "/v1/verticals/#{jobs.id}",
            params: { vertical: { name: "" } },
            headers: authorization_header
      end

      it "does change vertical name in the database" do
        subject
        expect(jobs.name).to eq("Jobs")
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
        put "/v1/verticals/#{jobs.id}",
            params: { vertical: { name: "Business" } },
            headers: authorization_header
      end

      it "does not change vertical name in the database" do
        subject
        expect(jobs.name).to eq("Jobs")
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("has already been taken")
      end
    end

    context "name is given and is unique" do
      subject do
        put "/v1/verticals/#{jobs.id}",
            params: { vertical: { name: "Social Media" } },
            headers: authorization_header
      end

      it "changes vertical name in the database" do
        subject
        jobs.reload
        expect(jobs.name).to eq("Social Media")
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(202)
        expect(JSON.parse(response.body)["vertical"]["name"]).to eq("Social Media")
      end
    end
  end

  describe "DELETE /v1/verticals/:id" do
    let!(:education) { create(:vertical, :valid, name: "Education") }

    context "id in params is wrong" do
      subject do
        delete "/v1/verticals/#{education.id + 'eeee'}",
               headers: authorization_header
      end

      it "does not delete record from db" do
        expect { subject }.to_not change(Vertical, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(404)
      end
    end

    context "id in params is correct" do
      subject do
        delete "/v1/verticals/#{education.id}",
               headers: authorization_header
      end

      it "removes vertical record from db" do
        expect { subject }.to change(Vertical, :count).by(-1)
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(202)
        expect(JSON.parse(response.body)["message"]).to eq("Vertical deleted successfully")
      end
    end
  end
end
