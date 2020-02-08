# frozen_string_literal: true

require "rails_helper"

RSpec.describe Course, type: :model do
  let(:vertical) { create(:vertical, :valid, name: "Health & Wellness") }
  let(:weight_loss) { create(:category, :valid, name: "Weight Loss", vertical_id: vertical.id) }
  let(:valid_course) { build(:course, :valid, name: "How To Lose Weight", category: weight_loss)}
  let(:invalid_course) { build(:course, :invalid, category: weight_loss) }

  describe "validation" do
    context "course name is given" do
      it "is valid" do
        expect(valid_course).to be_valid
      end

      it "has a default state of 'active'" do
        expect(valid_course.state).to eq("active")
      end

      it "has a default Author of empty string" do
        expect(valid_course.author).to eq("")
      end
    end

    context "course name is not given" do
      it "is invalid" do
        invalid_course.valid?
        expect(invalid_course.errors["name"]).to include("can't be blank")
      end
    end

    context "category_id not given" do
      it "is invalid" do
        valid_course.category_id = nil

        valid_course.valid?

        expect(valid_course.errors["category_id"]).to include("can't be blank")
      end
    end
  end

  describe "associations" do
    it {
      should belong_to(:category)
    }
  end
end
