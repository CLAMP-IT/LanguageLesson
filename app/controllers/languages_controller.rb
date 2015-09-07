class LanguagesController < ApplicationController
  def with_lessons
    @languages = Language
                 .includes(:lessons)
                 .references(:lessons)
                 .where("languages.id in (select language_id from lessons)")
  end
end
