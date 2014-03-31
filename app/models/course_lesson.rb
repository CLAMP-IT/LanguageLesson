class CourseLesson < ActiveRecord::Base
  belongs_to :course
  belongs_to :lesson
  #attr_accessible :course, :lesson
end
