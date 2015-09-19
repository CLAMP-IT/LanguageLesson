class LessonElement < ActiveRecord::Base
  include RankedModel
  ranks :row_order, :with_same => :lesson_id
  belongs_to :lesson
  belongs_to :presentable, polymorphic: true
  has_one :course, through: :lesson

  def first?
    lesson.lesson_elements.index(self) == 0
  end

  def last?
    lesson.lesson_elements.index(self) == (lesson.lesson_elements.size - 1)
  end
end
