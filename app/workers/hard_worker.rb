class HardWorker
  include Sidekiq::Worker

  def perform(oauth_token, omniauth_provider, contacts =nil)    
  	if omniauth_provider == 'facebook'
  		Conntact.get_facebook_contact(oauth_token)  
  	elsif omniauth_provider == 'twitter'
  		Contact.get_twitter_contact
    elsif omniauth_provider == 'linkedin'
       Contact.get_linkedin_contact
    elsif omniauth_provider == 'yahoo'
       Contact.get_yahoo_contact(contacts)  
    elsif omniauth_provider =='gmail'      
       Contact.get_gmail_contact(contacts)     
  	else
  		# Contact.get_linkedin_contact(contacts) 
  	end
  end
  	
end