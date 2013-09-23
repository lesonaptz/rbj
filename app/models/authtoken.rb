class Authtoken < ActiveRecord::Base

	after_create :background_jod_add_contact

	def self.create_save_token(params)
		Authtoken.create(params)
	end

	def background_jod_add_contact
		oauth = Authtoken.last
		HardWorker.perform_async(oauth.token, oauth.provider)         
	end

end
