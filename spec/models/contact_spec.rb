require 'spec_helper'

describe Contact do

	describe 'checking visit users' do
		before :each do
			@omniauth_hash = {
	     	:extra => {   
	      	:raw_info  => {:email => "lesonapt@gmail.com"}
	      },
	      :provider => 'facebook',
	      'credentials' => {'token' => 'testtoken234tsdf'}
    	}

		end

		it "the first visits" do
			FactoryGirl.create(:user, email: "othermail@rbj.com" )
			user = Contact.check_visit_user(@omniauth_hash)
			expect { user}.to_not change{User.count}.from(1).to(2)
		end

		it "users have visited" do
			 FactoryGirl.create(:user)	
			 user = Contact.check_visit_user(@omniauth_hash)
			 expect {user}.to_not change{User.count}.from(1).to(2)			 
		end
	end

	describe 'save contacts ' do
			before :each do
				@data_contact = [{
					:email 		=> "lesonapt@gmail.com",
        	:name  		=> "lesonapt",
        	:phone 		=> "0984690612",
        }]
			end

			it 'add new contact' do
				Contact.contact_save(@data_contact)
				Contact.count.should == 1				
			end
	end


end
