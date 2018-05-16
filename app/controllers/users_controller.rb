class UsersController < ApplicationController

  def index
  	@users = User.all
  	@user = User.find_by_id(params[:id])           
  end

  def new
  	@user = User.new
  end

  def create
  	user = User.new(user_params)
  	if user.save
  		flash[:message] = 'user created ok'
  		redirect_to '/users'
  	else
  		flash[:message] = 'try again'
  		redirect_to users_new_path
  	end
  end

  def show
  	    
  end
      

  private
  def user_params
  	params.require(:user).permit(:email, :password)
  end

 
end