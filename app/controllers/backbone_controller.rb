class BackboneController < ApplicationController
  layout 'backbone'

  before_filter :set_current_user

  def set_current_user
    @user = User.first

    gon.rabl "app/views/users/show.json.rabl", as: "current_user"
  end

  def lesson
    gon.rabl "app/views/lessons/show.json.rabl", as: 'lesson'
  end

 def start
    require 'oauth'
    require 'oauth/request_proxy/rack_request'

    begin
      signature = OAuth::Signature.build(request, :consumer_secret => ENV['OAUTH_SECRET'])
      signature.verify() or raise OAuth::Unauthorized
    rescue OAuth::Signature::UnknownSignatureMethod,
      OAuth::Unauthorized
      @response = %{unauthorized attempt. make sure you used the consumer secret "#{ENV['OAUTH_SECRET']}"}
      
      return
    end

    %w(lis_outcome_service_url lis_result_sourcedid lis_person_name_full lis_person_contact_email_primary context_title).each { |v| session[v] = params[v] }

    email_address = params[:lis_person_contact_email_primary]
    
    @user = User.find_by_email(email_address)

    unless @user
      @user = User.create(:email => email_address,
                         :name => params[:lis_person_name_full],
                         :moodle_id => params[:user_id])
    end
    
    session[:user_id] = @user.id

    redirect_to lti_choose_lesson_path
  end
end
