class SessionsController < ApplicationController
  
  def new
  end

  def create
    
    omniauth = request.env["omniauth.auth"]
    api_user_token = omniauth['credentials']['token']  
    data_render = Contact.get_contact_api(api_user_token, omniauth.provider)
    render :text => data_render.to_yaml
    # data = omniauth.extra.raw_info
    # if @user = User.where(:email => data.email || data.emailAddress || ['twitter',data.id,'@gmail.com'].join('') ).first      
    #   @user
    # else 
    #   @user = User.create!(:email => data.email || data.emailAddress || ['twitter',data.id,'@gmail.com'].join(''), :password => Devise.friendly_token[0,20]) 
    # end

    # if @user.persisted?      
    #   flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    #   sign_in_and_redirect @user
    #   # redirect_to ajax_showform_path(@user, :foo => data)
    # else      
    #   session["devise.facebook_data"] = request.env["omniauth.auth"]
    #   redirect_to new_user_registration_url
    # end

  end

end


