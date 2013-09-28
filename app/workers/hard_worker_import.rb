class HardWorkerImport
  include Sidekiq::Worker

  def perform(oauth_token, omniauth_provider)
  	if omniauth_provider == 'facebook'
  		Conntact.get_facebook_contact(oauth_token)  
  	elsif omniauth_provider == 'twitter'
  		Contact.get_twitter_contact
    elsif omniauth_provider = 'yahoo'
       Contact.get_yahoo_contact  
    elsif omniauth_provider = 'gmail'
       Contact.get_gmail_contact     
  	else
  		Contact.get_linkedin_contact 
  	end
  end
  	
end