class BackboneController < ApplicationController
  layout 'backbone'

  before_filter :set_current_user

  def set_current_user
    @user = User.first

    gon.rabl "app/views/users/show.json.rabl", as: "current_user"
  end

  def lesson
    @lesson = Lesson.find(params[:id])

    gon.rabl "app/views/lessons/show.json.rabl", as: 'lesson'
  end
end
