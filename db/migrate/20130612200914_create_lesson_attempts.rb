class CreateLessonAttempts < ActiveRecord::Migration
  def change
    create_table :lesson_attempts do |t|
      t.references :user
      t.references :lesson
      t.references :course

      t.timestamps
    end
    add_index :lesson_attempts, :user_id
    add_index :lesson_attempts, :lesson_id
    add_index :lesson_attempts, :course_id
  end
end
