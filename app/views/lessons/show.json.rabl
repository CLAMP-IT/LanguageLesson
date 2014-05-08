object @lesson

extends "lessons/_base"

#child :page_elements do
  #attributes :pageable_type
child :pageables, root: 'page_elements' do
  attributes :type, :title, :content
end
#end 

node do
  {
    environment: Rails.env,
  }
end

