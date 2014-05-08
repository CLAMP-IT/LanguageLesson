class Lesson < ActiveRecord::Base
  has_many :course_lessons
  has_many :courses, through: :course_lessons
  #attr_accessible :name, :graded, :auto_grading, :hide_previous_answer, :submission_limited, :submission_limit, :course, :default_correct, :default_incorrect, :max_score
  has_many :questions
  has_many :pages
  has_many :page_elements, through: :pages
  #has_many :pageables, source: :pageable, source_type: "Pageable", through: :page_elements

  def full_name
    "#{course.name} - #{self.name}"
  end

  def pageables
    page_elements.rank(:row_order).collect {|e| e.pageable}
  end
end
