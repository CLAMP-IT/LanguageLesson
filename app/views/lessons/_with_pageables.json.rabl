extends "lessons/_base"

#child :pageables, root: 'page_elements' do
child :presentables, root: 'lesson_elements' do
  attribute :id => :element_id
  attributes :type, :title, :content
  child :recording, if: :recording do
    glue :file do
      attributes url: :url, content_type: :content_type, size: :file_size     
    end
  end
end
