require 'spec_helper'


describe SessionsController, "OmniAuth" do
  include Devise::TestHelpers	
  before do
    request.env["devise.mapping"] = Devise.mappings[:user] 
  end


  it "login whith twitter" do
    request.env["omniauth.auth"] = stub_env_for_omniauth_twitter
    get 'create' 
    assigns[:user].should be_true    
  end

  it "login with linkedin" do
    request.env["omniauth.auth"] = stub_env_for_omniauth_linkedin    
    get 'create' 
     assigns[:user].should be_true   
  end

  it "login with facebook" do
    request.env["omniauth.auth"] = stub_env_for_omniauth_facebook    
    get 'create' 
    assigns[:user].should be_true   
  end


  def stub_env_for_omniauth_facebook
    omniauth_hash = {
     :extra => {
      :provider => "facebook",      
      :raw_info   => {:name   => "Le Anh Son", :email => "lesonapt@gmail.com", :id => "1234"},
      :credentials => {:token => "testtoken234tsdf"}
      }
    }
    OmniAuth.config.add_mock(:facebook, omniauth_hash)
  end

  def stub_env_for_omniauth_twitter
    omniauth_hash = {
     :extra => {
      :provider => "twitter",      
      :raw_info   => {:name   => "Le Anh Son", :id => "1731160094", },
      :credentials => {:token => "testtoken234tsdf"}
      }
    }
    OmniAuth.config.add_mock(:twitter, omniauth_hash)
  end

  def stub_env_for_omniauth_linkedin
     omniauth_hash = {
     :extra => {
      :provider => "linkedin",      
      :raw_info   => {:name   => "Le Anh Son",:id => "1234"},
      :credentials => {:token => "testtoken234tsdf"}
      }
    }    
    OmniAuth.config.add_mock(:linkedin, omniauth_hash)
  end


end
