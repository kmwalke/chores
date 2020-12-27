class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      session[:user_id]          = user.id
      destination                = session[:orig_destination] || root_path
      session[:orig_destination] = nil
      redirect_to destination, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path notice: 'Logged out!'
  end
end
