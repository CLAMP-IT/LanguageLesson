class BackboneController < ApplicationController
  layout 'backbone'

  def lesson
    @lesson = Lesson.find(params[:id])

    gon.rabl "app/views/lessons/show.json.rabl", as: 'lesson'
  end
end
