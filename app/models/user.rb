class User < ActiveRecord::Base
  #attr_accessible :email, :moodle_id, :name
  validates_presence_of :email, :name

  has_many :question_attempts
  
  belongs_to :institution

  def self.with_question_attempts_for_activity(activity)
    joins(:question_attempts).merge( QuestionAttempt.for_activity(activity) )
  end
end
