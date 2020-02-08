class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :name, null: false
      t.string :author, null: false, default: ''
      t.uuid :category_id, null: false
      t.string :state, null: false, default: 'active'

      t.timestamps
    end

    add_index :courses, :name
    add_index :courses, :category_id
    add_foreign_key :courses, :categories, column: :category_id
  end
end
