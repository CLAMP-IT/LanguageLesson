class QuestionRecording < ActiveRecord::Base
  belongs_to :question
  belongs_to :recording

  #attr_accessible :question, :recording
end
