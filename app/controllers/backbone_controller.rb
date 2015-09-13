class BackboneController < ApplicationController
  layout 'backbone'

  before_filter :set_current_user

  def set_current_user
    @user = User.first

    gon.rabl "app/views/users/show.json.rabl", as: "user"
  end

  def index
    if Rails.env.development?
      @user = User.find_by_email(ENV['DEV_USER_EMAIL'])
      @institution = Institution.find_by_hostname(ENV['DEV_INSTITUTION_HOSTNAME'])
      @lesson = Lesson.find(ENV['DEV_LESSON_ID'])

      @course = Course.find_or_create_by(institution: @institution,
                                         context_id: 1,
                                         context_label: "lltest",
                                         context_title: "LTI Test Course",
                                         name: "LTI Test Course")

      @activity = Activity.find_or_create_by(course: @course,
                                             name: "LTI Start 3",
                                             resource_link_id: 1,
                                             doable_id: @lesson.id,
                                             doable_type: 'Lesson')

      gon.user = @user
      gon.institution = @institution
      gon.course = @course
      gon.administrator = ENV['DEV_ADMINISTRATOR_STATUS']
      gon.activity = @activity
    end
  end
  
  def lesson
    gon.rabl "app/views/lessons/show.json.rabl", as: 'lesson'
  end

  def signS3put
    s3_direct_post = S3_BUCKET.presigned_post(key: "recordings/#{SecureRandom.uuid}/${filename}",
                                              success_action_status: 201,
                                              acl: :public_read)
                      

    render json: { signed_post: s3_direct_post.fields,
                   url: s3_direct_post.url.to_s }#url: "http://s3.amazonaws.com/#{ENV['S3_BUCKET']}/foo.ogg" }
  end
end
