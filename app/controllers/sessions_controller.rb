class SessionsController < ApplicationController
  

  def new
  end

  def create
    omniauth = request.env["omniauth.auth"]
    @user = Contact.check_visit_user(omniauth)      
    if @user.persisted?
      flash[:notice] = "Success login with"+" "+omniauth.provider
      sign_in_and_redirect @user
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end


