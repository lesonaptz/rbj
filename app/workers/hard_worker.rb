class HardWorker
  include Sidekiq::Worker

  def perform(api_user_token, omniauth_provider)
    	Contact.get_contact_api(api_user_token, omniauth_provider)  
  end
end