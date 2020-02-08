# frozen_string_literal: true

class Course < ApplicationRecord
  validates :name, presence: true
  validates :category_id, presence: true
  belongs_to :category

  scope :order_created, -> { order(created_at: :asc) }

  delegate :vertical, to: :category
end
