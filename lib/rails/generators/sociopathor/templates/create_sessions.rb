class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.string      :session_id, :null => false
      t.text        :data
      t.timestamps
    end

    add_index :sessions, :session_id
  end

  def self.down
    drop_table :sessions
  end
end
