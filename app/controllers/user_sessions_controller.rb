class UserSessionsController < ApplicationController
  protect_from_forgery :except => [:create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    services = %w(twitter facebook)
    @services = services.include?( params[ :service ] ) ? [ params[ :service ] ] : services
    @return_to = params[ :return_to ]
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    services = %w(twitter facebook)
    @services = services.include?( params[ :service ] ) ? [ params[ :service ] ] : services
    session[ :return_to ] = params[ :return_to ] if params[ :return_to ]
    @return_to = params[ :return_to ]

    @user_session.save do |result|
      if result
        current_user.save

        begin
          return_path = default_auth_return_path
        rescue
          return_path = root_path
        end

        redirect_back_or_default return_path, :notice => 'Account updated'
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

  begin
    extend LocalUserSessionsController::ClassMethods
  rescue
  end

  begin
    include LocalUserSessionsController::InstanceMethods
  rescue
  end
end
