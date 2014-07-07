extends "lessons/_base"

child :pageables, root: 'page_elements' do
  attribute :id => :element_id
  attributes :type, :title, :content
end
