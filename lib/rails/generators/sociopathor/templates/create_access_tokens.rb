class CreateAccessTokens < ActiveRecord::Migration
  def self.up
    create_table :access_tokens do |t|
      t.integer     :user_id
      t.string      :type,    :limit => 30
      t.string      :key
      t.string      :token,   :limit => 1024
      t.string      :secret
      t.boolean     :active
      t.timestamps
    end
    
    add_index :access_tokens, :key, :unique
  end

  def self.down
    drop_table :access_tokens
  end
end
