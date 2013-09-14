class Contact < ActiveRecord::Base
	# validates_format_of :email, :with => /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/, :message => 'email not fomat'
	validates_numericality_of :phone, :only_integer => true, :message => "can only be whole number."

	def self.get_contact_api(api_token, type = 'facebook')
		contact_data = Array.new

		if type == 'facebook'
			graph = Koala::Facebook::API.new(api_token)
	    user = graph.get_object("me")
	    contact_data = graph.fql_query("select name, uid from user where uid in (select uid2 from friend where uid1 = #{user["id"]} )")
		elsif type == 'twitter'
			contact_data = Twitter.friends		
		else
			client = LinkedIn::Client.new('muh3vc5p2rlw', 'WNPnOxdQFqbIDnci')
			client.request_token.authorize_url
			client.authorize_from_access('c28dce3f-3e47-442c-8636-39aff85d7830', 'df307fa4-2942-450a-a799-1308e1a1bedc') 
			contact_data = client.connections
		end					
		self.filter_contact(contact_data, type)
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
