class Lesson < ActiveRecord::Base
  has_many :course_lessons
  has_many :courses, through: :course_lessons
  #attr_accessible :name, :graded, :auto_grading, :hide_previous_answer, :submission_limited, :submission_limit, :course, :default_correct, :default_incorrect, :max_score
  has_many :questions
  has_many :pages

  def full_name
    "#{course.name} - #{self.name}"
  end
end
