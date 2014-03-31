class CreateCourseLessons < ActiveRecord::Migration
  def change
    create_table :course_lessons do |t|
      t.references :course
      t.references :lesson

      t.timestamps
    end
    add_index :course_lessons, :course_id
    add_index :course_lessons, :lesson_id
  end
end
