class AddRespondedFieldToQuestionAttempts < ActiveRecord::Migration
  def change
    add_column :question_attempts, :responded, :boolean, default: false
  end
end
