# frozen_string_literal: true

class Vertical < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :categories,
           dependent: :destroy,
           foreign_key: :vertical_id

  scope :order_created, -> { order(created_at: :asc) }
end
