class ActivitiesController < ApplicationController
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(activity_params)
        format.json { head :no_content }
      else
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def activity_params
    params.require(:activity).permit!
  end
end
