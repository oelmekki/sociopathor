# encoding : utf-8
class User < ActiveRecord::Base
  acts_as_authentic do |config|                                                                                                                    
    config.validate_email_field    = false
    config.validate_login_field    = false
    config.validate_password_field = false
  end

  has_many :access_tokens, :dependent => :destroy
  
  def facebook
    if token = authenticated_with?( :facebook )
      @facebook ||= JSON.parse token.get( "/me" )
    end
  end
  
  def twitter
    if token = authenticated_with?( :twitter )
      @twitter ||= JSON.parse token.get( "/account/verify_credentials.json" ).body
    end
  end

  def has_unlinked_accounts?
    %w(twitter facebook).any? { |service| ! authenticated_with?( service.to_sym ) }
  end

  def twitter_restful
    authenticated_with?( :twitter )
  end

  def facebook_restful
    authenticated_with?( :facebook )
  end

  def default_auth_service
    @default_auth_service ||= authenticated_with.sort_by { |service| authenticated_with?( service ).updated_at }.first
  end

  def not_connected_with
    default_auth_service == 'twitter' ? 'Facebook' : 'Twitter'
  end

  def services_available
    %w(twitter facebook)
  end
  
  def profile
    unless @profile
      @profile = if default_auth_service == 'facebook' and facebook
        {
          :id     => facebook["id"],
          :name   => facebook["name"],
          :avatar  => "https://graph.facebook.com/#{facebook["id"]}/picture",
          :link   => facebook["link"],
          :title  => "Facebook"
        }
      elsif default_auth_service == 'twitter' and twitter
        {
          :id     => twitter["id"],
          :name   => twitter["name"],
          :avatar  => twitter["profile_image_url"],
          :link   => "http://twitter.com/#{twitter["screen_name"]}",
          :title  => "Twitter"
        }
      else
        {
          :id     => "unknown",
          :name   => "User",
          :avatar  => "/images/icons/google.png",
          :link   => "/images/icons/google.png",
          :title  => "Google"
        }
      end
    end

    @profile
  end

  begin
    extend LocalUser::ClassMethods
  rescue
  end

  begin
    include LocalUser::InstanceMethods
  rescue
  end
end

