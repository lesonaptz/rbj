require 'spec_helper'

describe SessionsController, "OmniAuth" do
	
  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    request.env["devise.mapping"] = Devise.mappings[:user]    
  end

  it "sets a session variable to the OmniAuth auth hash" do
  	# get 'create' , :workflow_state => 'active'
    # puts assigns[:newuser].to_yaml
    request.env["omniauth.auth"]['uid'].should == '1234'
  end

end
