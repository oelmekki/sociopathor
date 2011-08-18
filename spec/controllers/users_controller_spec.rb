require 'spec_helper'

describe  UsersController do
  before :each do
    reset_env
  end

  describe 'GET check_auth' do
    describe 'when requesting for a service user is not auth with' do
      before :each do
        @current_user.stub!( :authenticated_with? ).with( :facebook ).and_return( false )
        get 'check_auth', :locale => :en, :service => 'facebook'
      end

      it 'should should render json saying user is not authentified' do
        response.body.should == { :service => 'facebook', :authenticated => false }.to_json
      end
    end

    describe 'when requesting for a service user is auth with' do
      before :each do
        @current_user.stub!( :authenticated_with? ).with( :facebook ).and_return( true )
        get 'check_auth', :locale => :en, :service => 'facebook'
      end

      it 'should should render json saying user is authentified' do
        response.body.should == { :service => 'facebook', :authenticated => true }.to_json
      end
    end
  end
end

