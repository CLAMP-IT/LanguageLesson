attribute :id => :element_id
attributes :type, :title, :content
child :recording, if: :recording do
  glue :file do
    attributes content_type: :content_type, size: :file_size
    node :recording_url do |file|
      file.url
    end
  end
end
