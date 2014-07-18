class LessonElement < ActiveRecord::Base
  include RankedModel
  ranks :row_order, :with_same => :lesson_id
  belongs_to :lesson
  belongs_to :presentable, polymorphic: true
  has_one :course, through: :lesson
end
