require 'authlogic'
require 'authlogic-connect'

module Sociopathor
  module Helpers
    def login_required
      if current_user.nil?
        redirect_to new_user_url
        true
      end
      false
    end

    def current_user_session
      @current_user_session ||= UserSession.find
    end
    
    def current_user
      @current_user ||= current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_path
        return false
      end
    end
  end

  class Engine < Rails::Engine
    initializer 'sociopathor.app_controller' do |app|
      ActiveSupport.on_load( :action_controller ) do
        helper_method :current_user_session, :current_user
        include Helpers
      end
    end
  end
end
