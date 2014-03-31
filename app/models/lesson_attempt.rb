class LessonAttempt < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  #attr_accessible :user, :lesson
  has_many :question_attempts
end
