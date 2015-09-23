class QuestionAttemptResponse < ActiveRecord::Base
  belongs_to :question_attempt
  belongs_to :user
  has_one :recording, as: :recordable, dependent: :destroy
  accepts_nested_attributes_for :recording
end
