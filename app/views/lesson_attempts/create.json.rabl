object @lesson_attempt
extends "lesson_attempts/_base"

child :question_attempts do
  extends "question_attempts/_with_question"
  extends "question_attempts/_with_responses"

  child :recordings, if: :recordings do
    glue :file do
      attributes url: :url, content_type: :content_type, size: :file_size     
    end
  end
end
