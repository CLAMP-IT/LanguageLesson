object @lesson_attempt
extends "lesson_attempts/_base"

child :question_attempts do
  extends "question_attempts/_with_question"
  extends "question_attempts/_with_responses"

  child :recordings, if: :recordings do
    attributes :full_url
  end
end
