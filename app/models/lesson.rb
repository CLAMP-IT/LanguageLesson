class Lesson < ActiveRecord::Base
  has_many :course_lessons
  has_many :courses, through: :course_lessons
  #attr_accessible :name, :graded, :auto_grading, :hide_previous_answer, :submission_limited, :submission_limit, :course, :default_correct, :default_incorrect, :max_score
  has_many :questions
  has_many :lesson_elements
  belongs_to :language
  
  def full_name
    "#{course.name} - #{self.name}"
  end

  def presentables
    lesson_elements.rank(:row_order).collect {|e| e.presentable}
  end

  scope :by_activity, -> (activity_id) { where("id in (SELECT doable_id FROM activities WHERE doable_type = 'Lesson' and id = ?)", activity_id).first }

end
