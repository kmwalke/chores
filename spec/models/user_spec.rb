require 'rails_helper'

RSpec.describe User, type: :model do
  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  it 'requires an email' do
    expect(described_class.create(email: '').errors).to have_key(:email)
  end

  it 'requires email uniqueness' do
    expect(described_class.create(email: create(:user).email).errors).to have_key(:email)
  end

  it 'requires a role' do
    expect(described_class.create(role: nil).errors).to have_key(:role)
  end

  it 'requires a TimeZone' do
    expect(described_class.create(time_zone: nil).errors).to have_key(:time_zone)
  end

  it 'requires a valid TimeZone' do
    expect(described_class.create(time_zone: 'not a time zone').errors).to have_key(:time_zone)
  end

  describe 'task list' do
    let(:user) { create(:user_with_tasks) }

    it 'has a list' do
      user.build_task_list
      expect(user.reload.task_list.size).to be > 0
    end

    it 'uses an algorithm to build a list', skip: 'not implemented' do
      # Replace the Random select in user.instantiate_tasks with an algorithm.
      # Select a mix of large and small tasks to give a set amount of xp/day
      expect(true).to be(false)
    end

    it 'does not instantiate twice' do
      user.build_task_list
      old_list = user.reload.task_list
      user.build_task_list
      expect(user.reload.task_list).to eq(old_list)
    end

    it 'defaults to todays list' do
      user.build_task_list
      user.reload
      expect(user.task_list).to eq(user.task_list(Time.zone.today))
    end

    it 'gets a past list' do
      user.build_task_list
      user.reload
      expect(user.task_list(Date.yesterday)).to be_a(Array)
    end

    it 'cannot get future list' do
      user.build_task_list
      user.reload
      expect { user.task_list(Date.tomorrow) }.to raise_error(ArgumentError)
    end

    it 'resets the xp_multiplier if yesterdays tasks undone' do
      create(:task_instance, task: user.tasks.first, created_on: Date.yesterday, completed_at: nil)
      user.increment_xp_multiplier!
      user.build_task_list
      expect(user.xp_multiplier).to eq(1)
    end
  end

  describe 'leveling' do
    let(:user) { create(:user) }

    it 'starts at level 1' do
      expect(user.level).to eq(1)
    end

    it 'starts at xp_multiplier 1' do
      expect(user.xp_multiplier).to eq(1)
    end

    it 'starts at xp 0' do
      expect(user.xp).to eq(0)
    end

    it 'does not allow xp to be set' do
      expect(described_class.new.respond_to?('xp=')).to be(false)
    end

    it 'receives xp' do
      user.add_xp(10)
      expect(user.xp).to eq(10)
    end

    it 'does not allow xp_multiplier to be set' do
      expect(described_class.new.respond_to?('xp_multiplier=')).to be(false)
    end

    it 'increments the xp multiplier' do
      old_multiplier = user.xp_multiplier
      user.increment_xp_multiplier!
      expect(user.reload.xp_multiplier).to be > old_multiplier
    end

    it 'decrements the xp multiplier' do
      user.increment_xp_multiplier!
      old_multiplier = user.xp_multiplier
      user.decrement_xp_multiplier!
      expect(user.reload.xp_multiplier).to be < old_multiplier
    end

    it 'does not decrement xp_multiplier below 1' do
      user.decrement_xp_multiplier!
      expect(user.reload.xp_multiplier).to eq(1)
    end

    it 'resets the xp_multiplier' do
      user.increment_xp_multiplier!
      user.reset_xp_multiplier!
      expect(user.reload.xp_multiplier).to eq(1)
    end

    it 'uses the xp multiplier' do
      user.increment_xp_multiplier!
      user.add_xp(10)
      expect(user.xp).to be > 10
    end

    it 'levels up' do
      user.add_xp(User::XP_PER_LEVEL + 1)
      expect(user.level).to eq(2)
    end

    it 'does not level down' do
      user.add_xp(User::XP_PER_LEVEL + 1)
      user.remove_xp(10)
      user.add_xp(1)

      expect(user.xp).to eq(User::XP_PER_LEVEL + 2)
    end

    it 'gets current xp this level' do
      user.add_xp(User::XP_PER_LEVEL * 1.75)
      expect(user.xp_this_level).to eq(User::XP_PER_LEVEL * 0.75)
    end

    it 'gets progress to next level' do
      user.add_xp(User::XP_PER_LEVEL * 1.75)
      expect(user.progress_to_level).to eq(0.75)
    end
  end

  describe 'rewards' do
    let(:user) { create(:user_with_tasks) }

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

  describe 'data privacy' do
    let(:user) { create(:user_with_tasks) }

    it 'does not cascade delete roles' do
      role_id = user.role.id
      user.destroy
      expect(Role.find_by(id: role_id)).not_to be_nil
    end

    it 'cascade deletes tasks' do
      task_ids = user.tasks.map(&:id)
      user.destroy

      task_ids.each do |id|
        expect(Task.find_by(id: id)).to be_nil
      end
    end
  end
end
