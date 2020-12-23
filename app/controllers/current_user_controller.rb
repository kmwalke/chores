class CurrentUserController < ApplicationController
  before_action :set_current_user

  def edit; end

  def update
    respond_to do |format|
      if @current_user.update(current_user_params)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @current_user.destroy
    respond_to do |format|
      format.html { redirect_to logout_path, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def current_user_params
    params.permit(:name, :email, :password, :password_confirmation, :name)
  end
end
