class CreateQuestionAttempts < ActiveRecord::Migration
  def change
    create_table :question_attempts do |t|
      t.references :lesson_attempt
      t.references :question
      t.references :user

      t.timestamps
    end
    add_index :question_attempts, :lesson_attempt_id
    add_index :question_attempts, :question_id
    add_index :question_attempts, :user_id
  end
end
