class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:orig_destination]
        orig                       = session[:orig_destination]
        session[:orig_destination] = nil
        redirect_to orig, notice: 'Logged in!'
      else
        redirect_to root_path, notice: 'Logged in!'
      end
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
