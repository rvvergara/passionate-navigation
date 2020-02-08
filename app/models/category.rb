# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  belongs_to :vertical

  scope :order_created, -> { order(created_at: :asc) }
end
