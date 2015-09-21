class Question < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  has_many :recordings, as: :recordable
  has_many :question_attempts
  has_many :lesson_elements, as: :presentable
  has_many :lessons, through: :lesson_elements
  
  scope :for_lesson, -> (lesson) { includes(lesson_elements: :lesson).references(lesson_elements: :lesson).where("lesson_elements.lesson_id = ?", lesson.id) } 
end
