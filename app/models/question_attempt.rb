class QuestionAttempt < ActiveRecord::Base
  belongs_to :lesson_attempt
  has_one :activity, through: :lesson_attempt
  belongs_to :question
  belongs_to :user
  has_one :recording, as: :recordable, dependent: :destroy
  accepts_nested_attributes_for :recording

  has_many :question_attempt_responses, dependent: :destroy

  scope :for_activity, -> (activity) { includes(lesson_attempt: :activity).references(:activity).where("activities.id = ?", activity.id) }
end
