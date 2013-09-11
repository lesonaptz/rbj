require 'spec_helper'

describe ContactController do

  describe "Authenticated examples" do

    before(:each) do
      user = FactoryGirl.create(:user)
      controller.stub!(:current_user).and_return(user)
    end
    

    it "should add new contact" do 
      contact = FactoryGirl.create(:contact)
      # post 'create', :post => contact
      expect { Contact.create }.to change{Contact.count}.from(0).to(1)
    end

  end
 
end
