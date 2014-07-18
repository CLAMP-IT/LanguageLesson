class ContentBlock < ActiveRecord::Base
  has_one :page_element, as: :pageable
  has_one :lesson_element, as: :presentable
  #attr_accessible :page_element, :title, :content
  has_one :recording, as: :recordable

  def type
    "ContentBlock"
  end
end
