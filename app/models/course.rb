class Course < ActiveRecord::Base
  #attr_accessible :moodle_id, :name
  has_many :course_lessons
  has_many :lessons, through: :course_lessons 
end
