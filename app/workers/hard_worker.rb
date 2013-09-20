class HardWorker
  include Sidekiq::Worker

  def perform(oauth_token, omniauth_provider)
  	if omniauth_provider == 'facebook'
  		Conntact.get_facebook_contact(oauth_token)  
  	elsif omniauth_provider == 'twitter'
  		Contact.get_twitter_contact
  	else
  		Contact.get_linkedin_contact 
  	end
  end
  	
end