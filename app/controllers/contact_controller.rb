class ContactController < ApplicationController
		before_filter :authenticate_user!
  def index

  end

  def new
  	render 'index'
  end

  def create
  	@post = Contact.new(post_params)
  	  if @post.save
    	  redirect_to root_path
  	else
    render 'index'
  end
	

  end

  def show

  end

  private
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
