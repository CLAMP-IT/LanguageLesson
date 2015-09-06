class QuestionAttempt < ActiveRecord::Base
  belongs_to :lesson_attempt
  belongs_to :question
  belongs_to :user
  has_many :recordings, as: :recordable
  has_many :question_attempt_responses, dependent: :destroy
end
