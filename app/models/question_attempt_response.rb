class QuestionAttemptResponse < ActiveRecord::Base
  belongs_to :question_attempt
  belongs_to :user_id
  has_one :response_recording, as: :recordable
end
