class LessonAttempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  #attr_accessible :user, :lesson
  has_many :question_attempts, dependent: :destroy

  validates_presence_of :user_id, :lesson_id
end
