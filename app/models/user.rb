class User < ActiveRecord::Base
  #attr_accessible :email, :moodle_id, :name
  validates_presence_of :email, :name

  has_many :question_attempts
  
  belongs_to :institution
end
