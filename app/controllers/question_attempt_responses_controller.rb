class QuestionAttemptResponsesController < ApplicationController
  def create
    @response = QuestionAttemptResponse.create(question_attempt_response_params)
    
    render json: @response
  end

  def update
    @response = QuestionAttemptResponse.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(question_attempt_response_params)
        format.json { render json: @response }
      else
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @question_attempt_response = QuestionAttemptResponse.find(params[:id])
    @question_attempt_response.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def question_attempt_response_params
    params.require(:question_attempt_response).permit!
  end
end
