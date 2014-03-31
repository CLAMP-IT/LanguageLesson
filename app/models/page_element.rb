class PageElement < ActiveRecord::Base
  include RankedModel
  ranks :row_order, :with_same => :page_id
  belongs_to :page
  belongs_to :pageable, polymorphic: true
  has_one :lesson, through: :page
  has_one :course, through: :lesson
  #attr_accessible :page, :row_order_position
end
