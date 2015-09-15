class QuestionAttempt < ActiveRecord::Base
  belongs_to :lesson_attempt
  belongs_to :question
  belongs_to :user
  has_one :recording, as: :recordable, dependent: :destroy
  accepts_nested_attributes_for :recording

  has_many :question_attempt_responses, dependent: :destroy
end
