# frozen_string_literal: true

class Vertical < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
