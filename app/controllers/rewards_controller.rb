class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]

  def index
    @rewards = Reward.all
  end

  def show
  end

  def new
    @reward = Reward.new
  end

  def edit
  end

  def create
    @reward = Reward.new(reward_params)

    if @reward.save
      redirect_to @reward, notice: 'Reward was successfully created.'
    else
      render :new
    end
  end

  def update
    if @reward.update(reward_params)
      redirect_to @reward, notice: 'Reward was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @reward.destroy
    redirect_to rewards_url, notice: 'Reward was successfully destroyed.'
  end

  private
    def set_reward
      @reward = Reward.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:name)
    end
end
