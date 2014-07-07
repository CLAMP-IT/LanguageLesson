attributes :id, :lesson_id, :user_id, :created_at, :updated_at

child :user do
  attributes :id, :name, :email
end

child :lesson do
  extends "lessons/_base"
end