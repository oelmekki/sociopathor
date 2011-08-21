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

      if ( last_cached_at || Time.new('0') ) < 1.week.ago
        if default_auth_service == 'facebook'
          facebook_id = facebook[ 'id' ]
          update_attributes!({ 
            :social_id          => facebook_id,
            :screen_name        => facebook[ 'name' ],
            :avatar_url         => "https://graph.facebook.com/#{facebook_id}/picture",
            :social_profile_url => facebook[ 'link' ],
            :last_cached_at     => Time.now
          })
        else
          twitter_screen_name = twitter[ 'screen_name' ]

          update_attributes!({ 
            :social_id          => twitter[ 'id' ],
            :screen_name        => '@' + twitter_screen_name,
            :avatar_url         => twitter[ 'profile_image_url' ],
            :social_profile_url => "http://twitter.com/#{twitter_screen_name}",
            :last_cached_at     => Time.now
          })
        end
      end

      @profile = {
        :id       => social_id,
        :name     => screen_name,
        :avatar   => avatar_url,
        :link     => social_profile_url,
        :title    => default_auth_service
      }
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

