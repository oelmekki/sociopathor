require 'authlogic'
require 'authlogic-connect'

module Sociopathor
  module Helpers
    def current_user_session
      @current_user_session ||= UserSession.find
    end
    
    def current_user
      @current_user ||= current_user_session && current_user_session.record
    end

    def check_authorized
      if current_user and ! current_user.profile

        msg = "Wait... Did you removed the app access ? Ok, let's start with a new account."

        current_user.destroy
        current_user_session.destroy

        respond_to do |format|
          format.html { redirect_to new_user_session_path, :notice => msg }
          format.json { render :json => { :redirect => new_user_session_path, :message => msg, :type => 'require_user' } }
        end
      end
    end
    
    def require_user
      if ! current_user
        store_location

        msg = "You must be logged in to access this page"

        respond_to do |format|
          format.html { redirect_to new_user_session_path, :notice => msg }
          format.json { render :json => { :redirect => new_user_session_path, :message => msg, :type => 'require_user' } }
        end

        return false
      end

    end

    def require_no_user
      if current_user
        store_location
        msg = "You must be logged out to access this page";

        respond_to do |format|
          format.html { redirect_to root_path, :notice => msg }
          format.json { render :json => { :redirect => root_path, :message => msg, :type => 'require_no_user' } }
        end

        return false
      end
    end

    def store_location
      session[ :return_to ] = request.fullpath unless request.fullpath =~ /\.json/
    end

    def redirect_back_or_default( default, options = {} )
      redirect_to( session[ :return_to ] || default, options )
      session[ :return_to ] = nil
    end
  end

  class Engine < Rails::Engine
    initializer 'sociopathor.app_controller' do |app|
      ActiveSupport.on_load( :action_controller ) do
        helper_method :current_user_session, :current_user
        before_filter :check_authorized
        include Helpers
      end
    end
  end
end


module AuthlogicConnect::Common::Variables
  def auth_callback_url( options = {} )
    if auth_controller.params[ :return_to ]
      options[ :return_to ] = auth_controller.params[ :return_to ]
    end

    auth_controller.url_for({:controller => auth_controller.controller_name, :action => auth_controller.action_name}.merge(options))
  end
end
