extends "question_attempts/_base"

child :recording, if: :recording do
  attributes :full_url
end

child question_attempt_responses: :responses do
  extends "question_attempt_responses/_base"
end
