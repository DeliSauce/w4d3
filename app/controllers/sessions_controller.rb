class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    # @user = User.new(session_params)
    user = User.find_by_credentials(
      session_params[:username],
      session_params[:password]
    )

    if user.nil?
      render json: "Credentials wrong..."
    else
      session[:session_token] = user.reset_session_token!
      redirect_to cats_url
    end


  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end


  private

  def session_params
    params.require(:user).permit(:username, :password)
  end

end
