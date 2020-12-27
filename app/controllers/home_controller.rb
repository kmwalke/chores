class HomeController < ApplicationController
  before_action :set_instance, only: [:complete]

  def index
    return unless logged_in?

    @user           = current_user
    @task_list      = current_user.task_list.sort
    @earned_rewards = current_user.earned_rewards.sort

    return if @user.task_list? || Rails.env.test?

    @user.instantiate_tasks
    redirect_to root_path
  end

  def complete
    @instance.toggle_complete!
    redirect_to root_path
  end

  def set_instance
    @instance = TaskInstance.find(params[:id])
    redirect_to root_path unless @instance.task.user_id == current_user.id
  end
end
