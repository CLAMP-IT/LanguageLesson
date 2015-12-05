attributes :id, :lesson_attempt_id, :question_id, :user_id, :created_at, :updated_at

child user: :user do
  attributes :id, :name, :email
end

