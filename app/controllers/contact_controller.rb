class ContactController < ApplicationController
	before_filter :authenticate_user!
  
  def index
  end

  def new
  	# render  'index'
    # render :partial => 'new'
  end

  def create 
    @postcontact = Contact.new(post_params)     
	  if @postcontact.save
  	  redirect_to root_path
  	else
      render 'index'
    end
  end

  def edit
    @post = Contact.find(params[:id])
    render :text => @post.inspect
  end
	
  def show
  end

  private
    def post_params
      params.require(:post).permit(:name, :email, :phone, :content)
    end
end
