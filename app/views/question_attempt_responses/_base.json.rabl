attributes :id, :question_attempt_it, :mark_start, :mark_end, :note, :created_at, :updated_at

child :recording, if: :recording do
  attributes :full_url
end
