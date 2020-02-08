# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Courses", type: :request do
  let!(:business_vert) { create(:vertical, :valid, name: "Business") }

  let!(:internet) { create(:category, :valid, vertical: business_vert, name: "Internet")}

  let!(:social_posting) do
    create(:course, :valid, name: "Social Media Posting",
                            author: "Andrea Vahl", category: internet)
  end
  let!(:sales_funnel) do
    create(:course, :valid, name: "How To Build A Sales Funnel",
                            author: "Anik Singal", category: internet)
  end

  describe "GET /v1/courses" do
    subject do
      get "/v1/courses"
    end

    it "sends a success response" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "renders json array of all courses" do
      subject
      expect(JSON.parse(response.body)["count"]).to eq(2)
    end
  end

  describe "GET /v1/courses/:id" do
    context "wrong id in params" do
      subject do
        get "/v1/courses/#{sales_funnel.id + 'eeee'}"
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(404)

        expect(JSON.parse(response.body)["message"]).to eq("Cannot find course")
      end
    end

    context "correct id in params" do
      subject do
        get "/v1/courses/#{sales_funnel.id}"
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "shows category data" do
        subject
        expect(JSON.parse(response.body)["course"]["category"]["id"]).to eq(internet.id)
        expect(JSON.parse(response.body)["course"]["category"]["name"]).to eq(internet.name)
      end
    end
  end

  describe "POST /v1/courses" do
    context "name is missing in params" do
      subject do
        post "/v1/courses",
             params: { course: { name: "",
                                 author: "Amy Porterfield", category: internet } }
      end

      it "does not add course to the database" do
        expect { subject }.not_to change(Course, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end
    end

    context "category id is missing in params" do
      subject do
        post "/v1/courses",
             params: { course: { name: "Facebook Marketing 101",
                                 author: "Amy Porterfield" } }
      end

      it "does not add course to the database" do
        expect { subject }.not_to change(Course, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["category_id"]).to include("can't be blank")
      end
    end

    context "params is complete" do
      subject do
        post "/v1/courses",
             params: { course: {
               name: "Facebook Marketing 101",
               category_id: internet.id,
               author: "Amy Porterfield"
             } }
      end

      it "adds record to the database" do
        expect { subject }.to change(Course, :count).by(1)
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)["course"]["name"]).to eq("Facebook Marketing 101")
      end
    end
  end

  describe "PUT /v1/courses/:id" do
    context "category id in params is wrong" do
      subject do
        put "/v1/courses/#{sales_funnel.id + 'ee'}",
            params: { course: { name: "Automate Your Sales Funnel",
                                category_id: internet.id,
                                author: "Russel Branson" } }
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(404)
      end
    end

    context "name is missing in params" do
      subject do
        put "/v1/courses/#{sales_funnel.id}",
            params: { course: { name: "",
                                category_id: internet.id,
                                author: "Russel Branson" } }
      end

      it "does change course name in the database" do
        subject
        sales_funnel.reload
        expect(sales_funnel.name).to eq("How To Build A Sales Funnel")
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)["errors"]["name"]).to include("can't be blank")
      end
    end

    context "complete and valid update params" do
      subject do
        put "/v1/courses/#{sales_funnel.id}",
            params: { course: { name: "Automate Your Sales Funnel",
                                category_id: internet.id,
                                author: "Russel Branson" } }
      end

      it "changes course name in database" do
        subject
        sales_funnel.reload
        expect(sales_funnel.name).to eq("Automate Your Sales Funnel")
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(:accepted)

        expect(JSON.parse(response.body)["course"]["name"]).to eq("Automate Your Sales Funnel")
      end
    end
  end

  describe "DELETE /v1/courses/:id" do
    context "id in params is wrong" do
      subject do
        delete "/v1/courses/#{sales_funnel.id + 'eeee'}"
      end

      it "does not delete record from db" do
        expect { subject }.to_not change(Course, :count)
      end

      it "sends an error response" do
        subject
        expect(response).to have_http_status(404)
      end
    end

    context "id in params is correct" do
      subject do
        delete "/v1/courses/#{sales_funnel.id}"
      end

      it "removes course record from db" do
        expect { subject }.to change(Course, :count).by(-1)
      end

      it "sends a success response" do
        subject
        expect(response).to have_http_status(202)
        expect(JSON.parse(response.body)["message"]).to eq("Course deleted successfully")
      end
    end
  end
end
