class HomeController < ApplicationController
  def index
    @user           = current_user
    @task_list      = current_user&.task_list&.sort
    @earned_rewards = current_user&.earned_rewards&.sort
  end

  def complete
    @instance = TaskInstance.find(params[:id])
    @instance.toggle_complete!
    redirect_to root_path
  end
end
