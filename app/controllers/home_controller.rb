class HomeController < ApplicationController
  def index
    @user           = current_user
    @task_list      = current_user&.task_list&.sort
    @earned_rewards = current_user&.earned_rewards&.sort
  end
end
