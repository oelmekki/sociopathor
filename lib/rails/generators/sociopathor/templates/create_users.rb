class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      # authlogic
      t.timestamps
      t.string    :login,               :null => true
      t.string    :email,               :null => true
      t.string    :crypted_password,    :null => true
      t.string    :password_salt,       :null => true
      t.string    :persistence_token,   :null => false
      t.string    :screen_name,         :null => true
      t.string    :avatar_url,          :null => true
      t.string    :social_profile_url,  :null => true
      t.string    :social_id,           :null => true
      t.integer   :login_count,         :default => 0, :null => false
      t.datetime  :last_request_at
      t.datetime  :last_login_at
      t.datetime  :current_login_at
      t.datetime  :last_cached_at
      t.string    :last_login_ip
      t.string    :current_login_ip

      # authlogic-connect
      t.integer   :active_token_id
    end

    add_index :users, :active_token_id
  end

  def self.down
    drop_table :users
  end
end
