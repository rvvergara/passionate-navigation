# frozen_string_literal: true

class Vertical < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  scope :order_created, -> { order(created_at: :asc) }
end
