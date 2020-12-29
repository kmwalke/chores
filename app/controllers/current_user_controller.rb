class CurrentUserController < ApplicationController
  before_action :set_current_user
  before_action :check_destroy_confirm, only: [:destroy]

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

  def delete; end

  def destroy
    @current_user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def current_user_params
    params.permit(:confirm, :email, :name, :password, :password_confirmation, :time_zone)
  end

  def check_destroy_confirm
    return if current_user_params[:confirm] == @current_user.name

    redirect_to edit_current_user_path, notice: 'You must type your user name exactly to confirm deletion.'
  end
end
