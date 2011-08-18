class UserSessionsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    services = %w(twitter facebook)
    @services = services.include?( params[ :service ] ) ? [ params[ :service ] ] : services
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    services = %w(twitter facebook)
    @services = services.include?( params[ :service ] ) ? [ params[ :service ] ] : services

    @user_session.save do |result|
      if result
        current_user.save
        redirect_to new_poll_url
      else
        render :action => :new
      end
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end
end
