class RecordingsController < ApplicationController
  def create
    @recording = Recording.new(recording_params)

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

  def recording_params
    params.require(:recording).permit!
  end
end
