attributes :id, :question_attempt_it, :mark_start, :mark_end, :note, :created_at, :updated_at

child :recording, if: :recording do
  glue :file do
    attributes url: :url, content_type: :content_type, size: :file_size     
  end
end
