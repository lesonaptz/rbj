class Contact < ActiveRecord::Base
	# validates_format_of :email, :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/, :message => 'email not fomat'
	validates_numericality_of :phone, :only_integer => true, :message => "can only be whole number."
	@@linkedin_config = {
      :site => 'https://api.linkedin.com',
      :authorize_path => '/uas/oauth/authenticate',
      :request_token_path => '/uas/oauth/requestToken?scope=r_basicprofile+r_fullprofile+r_network',
      :access_token_path => '/uas/oauth/accessToken'
  }


	def self.get_contact_api(api_token, type = 'facebook')
		contact_data = Array.new
		if type == 'facebook'
			@graph = Koala::Facebook::GraphAPI.new(api_token)
			# api_token = '346465042117861|NCRsUCHyvkf4OqbN4IGce9Cb4j0'
			# graph = Koala::Facebook::API.new(api_token)
	    # user = @graph.get_object("me")
	  	# las = graph.fql_query("select email, contact_email, name, uid from user where uid in (select uid2 from friend where uid1 = #{user["id"]} )")
			# @graph.put_object("100000639884100", "feed", :message => "Testing koala gem, Post to your feed by Lesonapt's App")
			# @graph.get_object("100000639884100"){|data| data['email']}
			# @graph.fql_query("select email, contact_email, name, uid from user where uid in (select uid2 from friend where uid1 = #{user["id"]} )")
			
			contact_data =  @graph.get_connections("me", "friends")
			# data.each do |f|
			# 	friend = @graph.get_object(f['id'])
			# 	contact_data << friend
			# end
			# contact_data = data 

		elsif type == 'twitter'
			# Twitter.update("I'm demo gemfile to post to wall")
		  # contact_data = Twitter.user(258286822)	
		  contact_data = Twitter.friends	
		else
			client = LinkedIn::Client.new('muh3vc5p2rlw', 'WNPnOxdQFqbIDnci', @@linkedin_config)
      client.authorize_from_access('81e68d7a-d35f-4ab5-bbec-ee6be5c88b9c', '309f3320-ffb0-4ec6-97ac-ec79202e1dfa')       
			contact_data = client.connections			
		end		
		self.contact_save(self.filter_contact(contact_data, type))
	end

	

	def self.filter_contact(contact_data, type = 'facebook')
		result = Array.new
		if type == 'linkedin'
			contact_data.all.each do |f|
			 	data = { "email" => [f.id ,'@linkedin.com'].join(''), "name" => [f.first_name, f.last_name].join(' '), "phone" => "0123456" }				
			 	result << data
			end
		else
			for i in 0..(contact_data.count)-1   
				if type == 'facebook'
					data = { "email" => [contact_data[i]["uid"],'@facebook.com'].join(''), "name" => contact_data[i]["name"], "phone" => "0123456" }
				else 
					data = { "email" => [contact_data.users[i].id ,'@twitter.com'].join(''), "name" => contact_data.users[i].name, "phone" => "0123456" }				
				end						
	      result << data
			end
		end
		result
	end

  def self.contact_save(contact_data)  	  	
		Contact.create(contact_data)			
	end
	
end

