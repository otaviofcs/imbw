# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  layout 'application'

  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :logged_in?

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

    # Check if the user is authorized
    #
    # Override this method in your controllers if you want to restrict access
    # to only a few actions or if you want to check if the user
    # has the correct rights.
    #
    # Example:
    #
    #  # only allow nonbobs
    #  def authorized?
    #    current_user.login != "bob"
    #  end
    #
    def authorized?(action = action_name, resource = nil)
      logged_in?
    end

    # Validates if the current session have a logged user.
    def user_required
      unless current_user
        store_location
        flash[:notice] = "Você deve estar logado para acessar essa página"
        redirect_to login_url
        return false
      end
    end

    # Validates if the current session have NO logged user.
    def no_user_required
      if current_user
        store_location
        flash[:notice] = "Você deve estar deslogado para acessar essa página"
        redirect_to root_url
        return false
      end
    end

    # Store location to redirect after login
    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
