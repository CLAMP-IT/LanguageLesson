class CreateLessonAttempts < ActiveRecord::Migration
  def change
    create_table :lesson_attempts do |t|
      t.references :user, index: true
      t.references :lesson, index: true
      t.references :course, index: true
      t.references :activity, index: true

      t.timestamps
    end
  end
end
