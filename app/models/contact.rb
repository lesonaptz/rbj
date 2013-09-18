class Contact < ActiveRecord::Base
	# validates_format_of :email, :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/, :message => 'email not fomat'
	validates_numericality_of :phone, :only_integer => true, :message => "can only be whole number."

	def oktest
	end

	def self.get_contact_api(api_token, type = 'facebook')
		contact_data = Array.new
		if type == 'facebook'
			# api_token = '346465042117861|NCRsUCHyvkf4OqbN4IGce9Cb4j0'
			# graph = Koala::Facebook::API.new(api_token)
	    # user = graph.get_object("me")
	  	# las = graph.fql_query("select email, contact_email, name, uid from user where uid in (select uid2 from friend where uid1 = #{user["id"]} )")
					
			
			@graph = Koala::Facebook::GraphAPI.new(api_token)
			data =  @graph.get_connections("me", "friends")
			data.each do |f|
				friend = @graph.get_object(f['id'])
				contact_data << friend
			end
			contact_data = data 

		elsif type == 'twitter'
			# Twitter.update("I'm demo gemfile to post to wall")
		  # contact_data = Twitter.user(258286822)	
		  contact_data = Twitter.friends	
		else
			# client = LinkedIn::Client.new('API Key', 'Secret Key')
			client = LinkedIn::Client.new('muh3vc5p2rlw', 'WNPnOxdQFqbIDnci')

			#auto get token
				# rtoken = client.request_token.token
			#auto get secret	
   		 # rsecret = client.request_token.secret

			# client.authorize_from_access('OAuth User Token:', 'OAuth User Secret') 
			client.authorize_from_access('c28dce3f-3e47-442c-8636-39aff85d7830', 'df307fa4-2942-450a-a799-1308e1a1bedc') 
			
			#  get profile success
			# contact_data = client.profile
			
			# get connections error
			contact_data = client.connections
		end		
		contact_data 		
		self.contact_add(self.filter_contact(contact_data, type))
	end

	def self.filter_contact(contact_data, type = 'facebook')
		result = Array.new
		
		for i in 0..(contact_data.count)-1   
			if type == 'facebook'
				data = { "email" => [contact_data[i]["uid"],'@gmail.com'].join(''), "name" => contact_data[i]["name"], "phone" => "0123456" }
			elsif type == 'twitter'
				data = { "email" => [contact_data.users[i].id ,'@gmail.com'].join(''), "name" => contact_data.users[i].name, "phone" => "0123456" }				
			else

			end						
      result << data
		end

		result
	end

  def self.contact_add(contact_data)  	  	
		Contact.create(contact_data)
	end
	
end
