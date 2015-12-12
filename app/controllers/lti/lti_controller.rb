class Lti::LtiController < ApplicationController
  layout 'backbone'
  
  before_action :lti_handshake

  before_action :allow_iframe

  rescue_from ::Exceptions::InstitutionNotAuthorizedError, with: :institution_not_authorized
  rescue_from OAuth::Unauthorized, with: :institution_not_authorized

  def fetch_user  
    @user = User.find(session[:user_id])
  end

  def lti_handshake
    require 'oauth'
    require 'oauth/request_proxy/rack_request'

    @institution = Institution.find_by_hostname params[:tool_consumer_instance_guid]
    raise ::Exceptions::InstitutionNotAuthorizedError unless @institution
  
    logger.debug params.inspect
    
    gon.institution = @institution
    
    begin
      signature = OAuth::Signature.build(request, consumer_secret: @institution.identifier)
            
      signature.verify() or raise OAuth::Unauthorized
    end

    %w(lis_outcome_service_url lis_result_sourcedid lis_person_name_full lis_person_contact_email_primary context_title).each { |v| session[v] = params[v] }
  end
  
  def start
    @user = User.where(email: params[:lis_person_contact_email_primary],
                       institution: @institution).first
    
    unless @user
      @user = User.create(email: params[:lis_person_contact_email_primary],
                          name: params[:lis_person_name_full],
                          institution: @institution)
    end
    
    gon.user = @user

    gon.administrator = params[:roles].include?('Administrator') 
    
    @course = Course.find_by_context_id params[:context_id]

    unless @course
      @course = Course.create(context_id: params[:context_id],
                              context_title: params[:context_title],
                              context_label: params[:context_label],
                              name: params[:context_title],
                              institution: @institution)
    end

    gon.course = @course
    
    @activity = Activity.where(course: @course, resource_link_id: params[:resource_link_id]).first

    unless @activity
      @activity = Activity.create(resource_link_id: params[:resource_link_id],
                                  name: params[:resource_link_title],
                                  course: @course)
    end

    gon.activity = @activity
  end

  def backbone_lesson_attempt
    @user = User.first

    gon.rabl "app/views/users/show.json.rabl", as: "current_user"

    render layout: 'backbone'
  end

  def show_params
  end

  private

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end

  def institution_not_authorized
    allow_iframe
    render template: 'lti/application/institution_not_authorized', status: :instition_not_authorized, layout: false
  end
end
