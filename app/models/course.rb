# frozen_string_literal: true

class Course < ApplicationRecord
  validates :name, presence: true
  belongs_to :category

  scope :order_created, -> { order(created_at: :asc) }
end
