class Lti::LtiController < ApplicationController
  layout 'lti_plain'

  before_filter :lti_handshake

  after_action :allow_iframe

  def fetch_user  
    @user = User.find(session[:user_id])
  end

  def lti_handshake
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
    
    #init_session

    logger.debug "LANDAU: #{session.inspect}"
    logger.debug "LANDAU: #{params.inspect}"

    %w(lis_outcome_service_url lis_result_sourcedid lis_person_name_full lis_person_contact_email_primary context_title).each { |v| session[v] = params[v] }

    email_address = params[:lis_person_contact_email_primary]
    
    @user = User.find_by_email(email_address)

    unless @user
      @user = User.create(:email => email_address,
                          :name => params[:lis_person_name_full],
                          :moodle_id => params[:user_id])
    end
    
    session[:user_id] = @user.id
  end
  
  def start
    redirect_to lti_choose_lesson_path
  end

  def backbone_lesson_attempt
    @user = User.first

    gon.rabl "app/views/users/show.json.rabl", as: "current_user"

    render layout: 'backbone'
  end

  def show_params
  end

  def choose_lesson
    init_session

    @user = User.find(session[:user_id])
                      
    @course = Course.find_by_name(session[:context_title])
  end

  def init_session
    # F'd up
    session[:init] = true

    logger.debug "SESSION"
    logger.debug session.inspect
  end

  private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
