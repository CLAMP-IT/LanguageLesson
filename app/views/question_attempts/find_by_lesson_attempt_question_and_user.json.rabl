object @question_attempt
extends "question_attempts/_base"

if @question_attempt
   child :recordings, if: :recordings do
     glue :file do
       attributes url: :url, content_type: :content_type, size: :file_size     
    end
  end
end