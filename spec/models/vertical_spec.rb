# frozen_string_literal: true

require "rails_helper"

RSpec.describe Vertical, type: :model do
  let(:valid_vertical) { build(:vertical, :valid) }
  let(:invalid_vertical) { build(:vertical, :invalid) }

  describe "validation" do
    context "vertical name is given" do
      it "is valid" do
        expect(valid_vertical).to be_valid
      end
    end

    context "name is not given" do
      it "is invalid" do
        invalid_vertical.valid?
        expect(invalid_vertical.errors["name"]).to include("can't be blank")
      end
    end

    context "duplicate vertical name" do
      it "is invalid" do
        valid_vertical.save
        duplicate_vertical = build(:vertical, :valid)

        duplicate_vertical.valid?
        expect(duplicate_vertical.errors["name"]).to include("has already been taken")
      end
    end
  end

  describe "associations" do
    it {
      should have_many(:categories)
        .with_foreign_key(:vertical_id)
        .dependent(:destroy)
    }
  end
end
