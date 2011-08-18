require 'authlogic'
require 'authlogic-connect'
require File.realpath( File.join( File.dirname( __FILE__ ), 'sociopathor_application_controller.rb' ) )

module Sociopathor
  class Engine < Rails::Engine
  end
end
