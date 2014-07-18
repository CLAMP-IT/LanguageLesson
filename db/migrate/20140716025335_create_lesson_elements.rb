class CreateLessonElements < ActiveRecord::Migration
  def change
    create_table :lesson_elements do |t|
      t.references :lesson, index: true
      t.integer :row_order
      t.integer :pageable_id
      t.integer :presentable_id
      t.string :presentable_type

      t.timestamps
    end
  end
end
