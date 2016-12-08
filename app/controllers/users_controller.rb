class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
       redirect_to new_user_url
     end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
