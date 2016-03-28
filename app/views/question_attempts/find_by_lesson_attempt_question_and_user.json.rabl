object @question_attempt
extends "question_attempts/_base"
extends "question_attempts/_with_responses"

if @question_attempt
  child :recording, if: :recording do
    extends "recordings/_base"
  end
end