class QuestionAttemptResponsesController < ApplicationController
  def create
    @response = QuestionAttemptResponse.create(question_attempt_response_params)

    render :show
  end

  def update
    @response = QuestionAttemptResponse.find(params[:id])
    
    if @response.update_attributes(question_attempt_response_params)
      render :show
    else
      format.json { render json: @response.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @question_attempt_response = QuestionAttemptResponse.find(params[:id])
    @question_attempt_response.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end


  def question_attempt_response_params
    # Rewrite Backbone association to conform with Rails expectations.
    params[:question_attempt_response][:recording_attributes] = params[:question_attempt_response].delete(:recording) if params[:question_attempt_response].has_key? :recording

    params.require(:question_attempt_response).permit(:question_attempt_id, :user_id, :note, :mark_start, :mark_end, recording_attributes: [:uuid, :url, :bucket_name, :file_name, :file_size, :content_type])
  end
end
