class QuestionAttemptResponse < ActiveRecord::Base
  belongs_to :question_attempt
  belongs_to :user_id
  has_one :recording, as: :recordable, dependent: :destroy
end
