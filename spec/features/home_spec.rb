require 'rails_helper'

RSpec.feature 'Home', type: :feature do
  describe 'logged out' do
    scenario 'displays the homepage' do
      visit root_path
      expect(page).to have_content('Log In')
      expect(page).not_to have_content('Tasks')
    end
  end

  describe 'logged in' do
    let(:user) { FactoryBot.create(:user_with_tasks) }

    before(:each) do
      user.add_xp(User::XP_PER_LEVEL * 3.2)
      user.instantiate_tasks
      user.reload
      login(user)
    end

    scenario 'displays the homepage' do
      visit root_path
      expect(page).to have_content(user.avatar)
      expect(page).to have_content('Tasks')
      expect(page).to have_content(user.next_reward.abbreviation)

      user.task_list.each do |item|
        expect(page).to have_content(item.task.name)
      end

      user.earned_rewards.each do |reward|
        expect(page).to have_content(reward.name)
      end
    end

    scenario 'hides xp multiplier when 1' do
      user.update(xp_multiplier: 1)
      visit root_path
      expect(page).not_to have_content("x#{user.xp_multiplier}")
    end

    scenario 'shows xp multiplier when >1' do
      user.update(xp_multiplier: 1.1)
      visit root_path
      expect(page).to have_content("x#{user.xp_multiplier}")
    end

    scenario 'completes a task' do
      instance = user.task_list.first
      visit root_path
      click_link user.task_list.first.task.name
      expect(current_path).to eq(root_path)
      expect(instance.reload.completed?).to eq(true)
    end

    scenario 'uncompletes a task' do
      instance = user.task_list.first
      instance.complete!
      visit root_path
      click_link user.task_list.first.task.name
      expect(current_path).to eq(root_path)
      expect(instance.reload.completed?).to eq(false)
    end

    scenario 'cannot complete another users tasks' do
      expect(true).to eq(false)
    end

    scenario 'add xp on task completion' do
      expect(true).to eq(false)
    end
  end
end
