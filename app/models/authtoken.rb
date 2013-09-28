class Authtoken < ActiveRecord::Base

	# after_create :background_jod_add_contact

	def self.create_save_token(params, contacts)
		Authtoken.create(params)		
		Authtoken.background_jod_add_contact(contacts)
	end


	def self.background_jod_add_contact(contacts)
		oauth = Authtoken.last		
				
		
		# HardWorker.perform_async(oauth.token, oauth.provider, contacts)   
		HardWorker.perform_async(oauth.token, oauth.provider, contacts) 
	end

end
