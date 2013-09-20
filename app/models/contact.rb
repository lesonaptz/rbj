class Contact < ActiveRecord::Base
	# validates_format_of :email, :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/, :message => 'email not fomat'
	validates_numericality_of :phone, :only_integer => true, :message => "can only be whole number."
	@@linkedin_config = {
      :site => 'https://api.linkedin.com',
      :authorize_path => '/uas/oauth/authenticate',
      :request_token_path => '/uas/oauth/requestToken?scope=r_basicprofile+r_fullprofile+r_network',
      :access_token_path => '/uas/oauth/accessToken'
  }

  def self.check_visit_user(omniauth)
  	data = omniauth.extra.raw_info
    if @user = User.where(:email => data.email || data.emailAddress || ['twitter',data.id,'@rbj.com'].join('') ).first      
      @user
    else
      HardWorker.perform_async(omniauth['credentials']['token'], omniauth.provider)   
      @user = User.create!(:email => data.email || data.emailAddress || ['twitter',data.id,'@rbj.com'].join(''), :password => Devise.friendly_token[0,20])       
    end    
  end

	def self.get_facebook_contact(api_token)
		result = Array.new
		@graph = Koala::Facebook::GraphAPI.new(api_token)
		contact_data =  @graph.get_connections("me", "friends")
		for i in 0..(contact_data.count)-1   
			data = { "email" => [contact_data[i]["uid"],'@facebook.com'].join(''), "name" => contact_data[i]["name"], "phone" => "0123456" }
      result << data
		end
		self.contact_save(result)
	end

	def self.get_twitter_contact
		result = Array.new
		contact_data = Twitter.friends
		for i in 0..(contact_data.count)-1 
		  data = { "email" => [contact_data.users[i].id ,'@twitter.com'].join(''), "name" => contact_data.users[i].name, "phone" => "0123456" }				
			result << data
		end
		self.contact_save(result)
	end	

	def self.get_linkedin_contact
		client = LinkedIn::Client.new('muh3vc5p2rlw', 'WNPnOxdQFqbIDnci', @@linkedin_config)
    client.authorize_from_access('81e68d7a-d35f-4ab5-bbec-ee6be5c88b9c', '309f3320-ffb0-4ec6-97ac-ec79202e1dfa')  
    result = Array.new
    client.connections.all.each do |f|
    	data = { "email" => [f.id ,'@linkedin.com'].join(''), "name" => [f.first_name, f.last_name].join(' '), "phone" => "0123456" }				
			result << data
    end    
		self.contact_save(result)
	end	

	def self.contact_save(contact_data)  	  	
		Contact.create(contact_data)			
	end
	
end

