# frozen_string_literal: true

class CreateVerticals < ActiveRecord::Migration[5.2]
  def change
    create_table :verticals, id: :uuid do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :verticals, :name, unique: true
  end
end
