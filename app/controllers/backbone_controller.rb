class BackboneController < ApplicationController
  layout 'backbone'

  before_filter :set_current_user

  def set_current_user
    @user = User.first

    gon.rabl "app/views/users/show.json.rabl", as: "user"
  end

  def index
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
