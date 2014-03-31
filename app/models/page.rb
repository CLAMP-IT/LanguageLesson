class Page < ActiveRecord::Base
  include RankedModel
  ranks :row_order, :with_same => :lesson_id
  belongs_to :lesson
  has_many :page_elements
  #attr_accessible :lesson, :title, :row_order_position
end
