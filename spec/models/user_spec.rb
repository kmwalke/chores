require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should require a name' do
    expect(User.create(name: '').errors).to have_key(:name)
  end

  it 'should require an email' do
    expect(User.create(email: '').errors).to have_key(:email)
  end

  it 'should require email uniqueness' do
    expect(User.create(email: FactoryBot.create(:user).email).errors).to have_key(:email)
  end

  it 'should require a role' do
    expect(User.create(role: nil).errors).to have_key(:role)
  end

  describe 'task list' do
    let(:user) { FactoryBot.create(:user_with_tasks) }

    it 'has a list' do
      user.instantiate_tasks
      expect(user.reload.task_list.size).to be > 0
    end

    it 'uses an algorithm to build a list', skip: 'not implemented' do
      # Replace the Random select in user.instantiate_tasks with an algorithm.
      # Select a mix of large and small tasks to give a set amount of xp/day
      expect(true).to be(false)
    end

    it 'will not instantiate twice' do
      user.instantiate_tasks
      old_list = user.reload.task_list
      user.instantiate_tasks
      expect(user.reload.task_list).to eq(old_list)
    end

    it 'defaults to todays list' do
      user.instantiate_tasks
      user.reload
      expect(user.task_list).to eq(user.task_list(Date.today))
    end

    it 'gets a past list' do
      user.instantiate_tasks
      user.reload
      expect(user.task_list(Date.yesterday)).to be_a(Array)
    end

    it 'cannot get future list' do
      user.instantiate_tasks
      user.reload
      expect { user.task_list(Date.tomorrow) }.to raise_error(ArgumentError)
    end
  end

  describe 'leveling' do
    let(:user) { FactoryBot.create(:user) }

    it 'should start at level 1' do
      expect(user.level).to eq(1)
    end

    it 'should start at xp_multiplier 1' do
      expect(user.xp_multiplier).to eq(1)
    end

    it 'should start at xp 0' do
      expect(user.xp).to eq(0)
    end

    it 'should not allow xp to be set' do
      expect(User.new.respond_to?('xp=')).to eq(false)
    end

    it 'should receive xp' do
      user.add_xp(10)
      expect(user.xp).to eq(10)
    end

    it 'should use the xp multiplier' do
      user.xp_multiplier = 1.3
      user.add_xp(10)
      expect(user.xp).to eq(13)
    end

    it 'cannot set xp_multiplier less than 1' do
      user.xp_multiplier = 0
      expect(user.save).to eq(false)
    end

    it 'should level up' do
      user.add_xp(User::XP_PER_LEVEL + 1)
      expect(user.level).to eq(2)
    end

    it 'should not level down' do
      user.add_xp(User::XP_PER_LEVEL + 1)
      user.remove_xp(10)
      user.add_xp(1)

      expect(user.xp).to eq(User::XP_PER_LEVEL + 2)
    end

    it 'should get current xp this level' do
      user.add_xp(User::XP_PER_LEVEL * 1.75)
      expect(user.xp_this_level).to eq(User::XP_PER_LEVEL * 0.75)
    end

    it 'should get progress to next level' do
      user.add_xp(User::XP_PER_LEVEL * 1.75)
      expect(user.progress_to_level).to eq(0.75)
    end
  end

  describe 'rewards' do
    let(:user) { FactoryBot.create(:user_with_tasks) }

    it 'has rewards' do
      expect(user.rewards.first).to be_a(Reward)
    end

    it 'has next_reward' do
      expect(user.next_reward).to be_a(Reward)
    end

    it 'earns rewards' do
      old_reward_count = user.earned_rewards.count
      user.add_xp(User::XP_PER_LEVEL + 1)
      expect(user.reload.earned_rewards.count).to eq(old_reward_count + 1)
    end

    it 'sets a next_reward' do
      user.add_xp(User::XP_PER_LEVEL + 1)
      expect(user.next_reward).to be_a(Reward)
    end

    it 'sets a new next_reward', skip: 'Not implemented' do
      old_reward = user.next_reward
      user.add_xp(User::XP_PER_LEVEL + 1)
      expect(user.reload.next_reward).not_to eq(old_reward)
    end
  end
end
