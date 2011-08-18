class UsersController < ApplicationController
  protect_from_forgery :except => [:update]

  def edit
    @user = current_user
    services = %w(twitter facebook)
    @services = services.include?( params[ :service ] ) ? [ params[ :service ] ] : services
  end
  
  def update
    @user = current_user
    services = %w(twitter facebook)
    @services = services.include?( params[ :service ] ) ? [ params[ :service ] ] : services
    @user.update_attributes params[ :user ] do |result|
      if result
        redirect_to new_poll_path, :notice => 'Account updated'
      else
        render :action => edit
      end
    end
  end

  def check_auth
    service = params[ :service ]
    render :json => { :service => service, :authenticated => !! current_user.authenticated_with?( service.to_sym ) }
  end
end

