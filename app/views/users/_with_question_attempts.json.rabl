attributes :id, :name, :email

child :question_attempts do
  extends "question_attempts/_with_responses"
end
