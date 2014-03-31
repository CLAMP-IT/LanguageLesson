class ContentBlock < ActiveRecord::Base
  has_one :page_element, as: :pageable
  #attr_accessible :page_element, :title, :content
end
