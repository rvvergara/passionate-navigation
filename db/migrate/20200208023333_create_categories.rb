# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name, null: false
      t.string :state, null: false, default: "active"
      t.uuid :vertical_id, null: false

      t.timestamps
    end
    add_index :categories, :name, unique: true
    add_index :categories, :vertical_id
    add_foreign_key :categories, :verticals, column: :vertical_id
  end
end
