# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  layout 'application'

  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  #
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation

  # Seta +TimeZone+ da requisição atual para a TimeZone do usuário atual, caso
  # o mesmo esteja logado.
  before_filter :set_user_time_zone

  protected
    # before_filter: Seta +TimeZone+ da requisição atual para a TimeZone do
    # usuário atual, caso o mesmo esteja logado.
    def set_user_time_zone
      Time.zone = current_user.time_zone if logged_in?
    end

    # Returns true or false if the user is logged in.
    # Preloads @current_user with the user model if they're logged in.
    def logged_in?
      !!current_user
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    # Retrieves the current logged user, if exists
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

end
