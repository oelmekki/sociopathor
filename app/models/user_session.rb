# encoding : utf-8
class UserSession < Authlogic::Session::Base
  begin
    extend LocalUserSession::ClassMethods
  rescue
  end

  begin
    include LocalUserSession::InstanceMethods
  rescue
  end
end
