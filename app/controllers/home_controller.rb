class HomeController < ApplicationController
  def index
    @user           = current_user
    @task_list      = current_user&.task_list
    @earned_rewards = current_user&.earned_rewards
  end
end
