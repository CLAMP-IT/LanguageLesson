class CreateQuestionAttemptResponses < ActiveRecord::Migration
  def change
    create_table :question_attempt_responses do |t|
      t.references :question_attempt, index: true
      t.references :user_id, index: true
      t.text :note
      t.string :mark_start
      t.string :mark_end

      t.timestamps
    end
  end
end
