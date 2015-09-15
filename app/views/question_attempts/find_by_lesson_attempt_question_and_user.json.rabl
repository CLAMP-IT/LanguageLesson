object @question_attempt
extends "question_attempts/_base"

if @question_attempt
  child :recording, if: :recording do
    extends "recordings/_base"
  end
end