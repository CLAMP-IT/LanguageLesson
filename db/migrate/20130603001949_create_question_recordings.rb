class CreateQuestionRecordings < ActiveRecord::Migration
  def change
    create_table :question_recordings do |t|
      t.references :question
      t.references :recording

      t.timestamps
    end
    add_index :question_recordings, :question_id
    add_index :question_recordings, :recording_id
  end
end
