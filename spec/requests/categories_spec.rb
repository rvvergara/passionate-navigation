# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Categories", type: :request do
  let!(:business_vert) { create(:vertical, :valid, name: "Business") }
  let!(:health_vert) { create(:vertical, :valid, name: "Health") }
  let!(:internet) { create(:category, :valid, vertical: business_vert, name: "Internet")}
  let!(:weight_loss) { create(:category, :valid, name: "Weight Loss", vertical: health_vert)}
  let(:mike) { create(:user) }
  let!(:login) { login_as(mike) }

  describe "unauthenticated requests" do
    it {
      get "/v1/categories"
      expect(response).to have_http_status(401)
    }
    it {
      post "/v1/categories",
           params: { category: { name: "Social Media", vertical_id: business_vert.id } }
      expect(response).to have_http_status(401)
    }
    it {
      put "/v1/categories/#{weight_loss.id}",
          params: { category: { name: "Weight Management", vertical_id: health_vert.id } }
      expect(response).to have_http_status(401)
    }
    it {
      delete "/v1/categories/#{internet.id}"
      expect(response).to have_http_status(401)
    }
  end

  describe "GET /v1/categories" do
    subject do
      get "/v1/categories",
          headers: authorization_header
    end

    it "sends a success response" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "renders json array of all categories" do
      subject
      expect(JSON.parse(response.body)["count"]).to eq(2)
    end
  end

  describe "POST /v1/categories" do
    context "name is missing in params" do
      subject do
        post "/v1/categories",
             params: { category: { name: "", vertical: business_vert } },
             headers: authorization_header
      end

      it "does not add category to the database" do
        expect { subject }.not_to change(Category, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end
    end

    context "duplicate name" do
      subject do
        post "/v1/categories",
             params: { category: { name: "Internet", vertical_id: business_vert.id } },
             headers: authorization_header
      end

      it "does not add category to the database" do
        expect { subject }.not_to change(Category, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("has already been taken")
      end
    end

    context "name is given and is unique" do
      subject do
        post "/v1/categories",
             params: { category: { name: "Social Media", vertical_id: business_vert.id } },
             headers: authorization_header
      end

      it "adds record to the database" do
        expect { subject }.to change(Category, :count).by(1)
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)["category"]["name"]).to eq("Social Media")
      end
    end
  end

  describe "PUT /v1/categories/:id" do
    context "category id in params is wrong" do
      subject do
        put "/v1/categories/#{weight_loss.id + 'ee'}",
            params: { category: { name: "Weight Management", vertical_id: health_vert.id } },
            headers: authorization_header
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(404)
      end
    end

    context "name is missing in params" do
      subject do
        put "/v1/categories/#{weight_loss.id}",
            params: { category: { name: "", vertical_id: health_vert.id } },
            headers: authorization_header
      end

      it "does change category name in the database" do
        subject
        expect(weight_loss.name).to eq("Weight Loss")
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end
    end

    context "duplicate name" do
      subject do
        put "/v1/categories/#{weight_loss.id}",
            params: { category: { name: "Internet", vertical_id: health_vert.id } },
            headers: authorization_header
      end

      it "does not change category name in the database" do
        subject
        expect(weight_loss.name).to eq("Weight Loss")
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("has already been taken")
      end
    end

    context "name is given and is unique" do
      subject do
        put "/v1/categories/#{weight_loss.id}",
            params: { category: { name: "Weight Management", vertical_id: health_vert.id } },
            headers: authorization_header
      end

      it "changes category name in the database" do
        subject
        weight_loss.reload
        expect(weight_loss.name).to eq("Weight Management")
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(202)
        expect(JSON.parse(response.body)["category"]["name"]).to eq("Weight Management")
      end
    end
  end

  describe "DELETE /v1/categories/:id" do
    context "id in params is wrong" do
      subject do
        delete "/v1/categories/#{internet.id + 'eeee'}",
               headers: authorization_header
      end

      it "does not delete record from db" do
        expect { subject }.to_not change(Category, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(404)
      end
    end

    context "id in params is correct" do
      subject do
        delete "/v1/categories/#{internet.id}",
               headers: authorization_header
      end

      it "removes category record from db" do
        expect { subject }.to change(Category, :count).by(-1)
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(202)
        expect(JSON.parse(response.body)["message"]).to eq("Category deleted successfully")
      end
    end
  end
end
