attribute :id => :element_id
attributes :type, :title, :content
child :prompt_audio, if: :prompt_audio do
  glue :file do
    attributes content_type: :content_type, size: :file_size
    node :recording_url do |file|
      file.url
    end
  end
end
