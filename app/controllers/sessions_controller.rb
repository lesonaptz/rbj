class SessionsController < ApplicationController
  def new
  end

  def create

    data = request.env['omniauth.auth'].extra.raw_info

    # render :text => data.inspect
    if user = User.where(:email => data.email || data.emailAddress || ['twitter',data.id,'@gmail.com'].join('') ).first
      @newuser = user     
    else 
      @newuser = User.create!(:email => data.email || data.emailAddress || ['twitter',data.id,'@gmail.com'].join(''), :password => Devise.friendly_token[0,20]) 
    end

    if @newuser.persisted?      
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @newuser, :event => :authentication
    else      
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end

  end

  def failure
  end
end
