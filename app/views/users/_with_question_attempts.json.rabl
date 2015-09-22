attributes :id, :name, :email

child :question_attempts do
  extends "question_attempts/_with_responses"
  extends "question_attempts/_with_question"		
end
