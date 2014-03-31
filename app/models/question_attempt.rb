class QuestionAttempt < ActiveRecord::Base
  belongs_to :lesson_attempt
  belongs_to :question
  belongs_to :user
  #attr_accessible :lesson_attempt, :question, :user, :lesson_attempt_id, :question_id, :user_id
  has_many :recordings, as: :recordable
end
