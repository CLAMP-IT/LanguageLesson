class RecordingsController < ApplicationController
  def create
    @recording = Recording.new(params[:recording])

    respond_to do |format|
      if @recording.save
        render :nothing => true
        #    format.html { redirect_to @question, notice: 'Question was successfully created.' }
        #    format.json { render json: @question, status: :created, location: @question }
      else
        #    format.html { render action: "new" }
        #    format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end
end
