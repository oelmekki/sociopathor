require 'rails/generators'
require 'rails/generators/migration'

module Sociopathor
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path( File.join( File.dirname( __FILE__ ), '..', 'templates') )
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_users.rb", "db/migrate/create_users.rb"
        migration_template "create_sessions.rb", "db/migrate/create_sessions.rb"
        migration_template "create_access_tokens.rb", "db/migrate/create_access_tokens.rb"
      end

      def copy_authlogic_config_files
        copy_file 'authlogic.yml', 'config/authlogic.yml'
        copy_file 'authlogic_connect_config.rb', 'config/initializers/authlogic_connect_config.rb'
      end
    end
  end
end

