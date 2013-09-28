class SessionsController < ApplicationController
  

  def new
  end

  def create
    omniauth = request.env["omniauth.auth"]
    # render :text => omniauth.to_yaml
    @user = Contact.check_visit_user(omniauth)      
    if @user.persisted?
      flash[:notice] = "Success login with"+" "+omniauth.provider
      sign_in_and_redirect @user
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
   
  def check_authtoken
    @auth = Authtoken.where(:provider => params[:provider], :email => current_user.email)
    if @auth.count() == 0      
      redirect_to '/contacts/'+params[:provider]
    else      
      flash[:contact_flash] = params[:provider] +' was be imported'
      redirect_to root_path
    end
     
  end

  def contacts_callback 
    @contacts = request.env['omnicontacts.contacts']
    flash[:contact_flash] = 'You have import contact from gmail'
    redirect_to root_path
  end

  def get_gmail_contact
    @contacts = request.env['omnicontacts.contacts']

    Contact.save_import_contacts('gmail', @contacts, current_user.email)
    flash[:contact_flash] = 'You have import contact from gmail'
    redirect_to root_path
    
    # @contacts = GmailContacts::Google.new(token).contacts
    # render :text => @contacts.to_yaml
  end

  def get_yahoo_contact
    @contacts = request.env['omnicontacts.contacts']
    Contact.save_import_contacts('yahoo', @contacts, current_user.email)
    flash[:contact_flash] = 'You have import contact from yahoo'
    redirect_to root_path
  end
end


