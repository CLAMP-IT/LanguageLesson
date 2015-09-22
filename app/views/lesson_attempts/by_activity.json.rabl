object false

child @lesson do 
  extends "lessons/_with_presentables"
end

child @users do
  extends "users/_with_question_attempts"
end

child @questions => :questions do
  attributes :id, :title
end

