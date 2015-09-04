object @question_attempt
extends "question_attempts/_base"

if @question_attempt
  child :recordings, if: :recordings do
    attributes :full_url   
  end
end