class Question < ActiveRecord::Base
  include RankedModel
  ranks :row_order
  has_one :lesson, through: :page
  has_many :answers
  #has_many :question_recordings
  #has_many :recordings, through: :question_recordings
  has_many :recordings, as: :recordable
  #attr_accessible :title, :content, :lesson, :row_order_position, :page_element, :recordable
end
