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
        expect(invalid_vertical).not_to be_valid
      end
    end

    context "duplicate vertical name" do
      it "is invalid" do
        valid_vertical.save
        duplicate_vertical = build(:vertical, :valid)

        expect(duplicate_vertical).to_not be_valid
      end
    end
  end
end
