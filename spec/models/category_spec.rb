# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  let(:vertical) { create(:vertical, :valid, name: "Health & Wellness") }
  let(:valid_category) { build(:category, :valid, name: "Weight Loss", vertical_id: vertical.id) }
  let(:invalid_category) { build(:category, :invalid)}

  describe "validation" do
    context "category name is given" do
      it "is valid" do
        expect(valid_category).to be_valid
      end

      it "has a default state of 'active'" do
        expect(valid_category.state).to eq("active")
      end
    end

    context "category name is not given" do
      it "is invalid" do
        invalid_category.valid?
        expect(invalid_category.errors["name"]).to include("can't be blank")
      end
    end

    context "duplicate category name" do
      it "is invalid" do
        valid_category.save

        duplicate_category = build(:category, :valid, name: "Weight Loss", vertical_id: vertical.id)

        duplicate_category.valid?
        expect(duplicate_category.errors["name"]).to include("has already been taken")
      end
    end
  end

  describe "associations" do
    it {
      should belong_to(:vertical)
    }
  end
end
