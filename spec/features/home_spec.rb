require 'rails_helper'

RSpec.feature 'Home', type: :feature do
  describe 'logged out' do
    scenario 'displays the homepage' do
      visit root_path
      expect(page).to have_content('Log In')
      expect(page).to have_no_content('Tasks')
    end
  end

  describe 'logged in with no tasks' do
    let(:user) { create(:user) }

    scenario 'displays the homepage' do
      login(user)
      visit root_path
      expect(page).to have_content(user.avatar)
      expect(page).to have_content('Tasks')
    end
  end

  describe 'logged in with tasks' do
    let(:user) { create(:user_with_tasks) }

    before do
      user.add_xp(User::XP_PER_LEVEL * 3.2)
      user.build_task_list
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
      user.reset_xp_multiplier!
      visit root_path
      expect(page).to have_no_content("x#{user.xp_multiplier}")
    end

    scenario 'shows xp multiplier when >1' do
      user.increment_xp_multiplier!
      visit root_path
      expect(page).to have_content("x#{user.xp_multiplier}")
    end

    scenario 'completes a task' do
      instance = user.task_list.first
      visit root_path
      click_link instance.task.name
      expect(page).to have_current_path(root_path, ignore_query: true)
      expect(instance.reload.completed?).to be(true)
    end

    scenario 'uncompletes a task' do
      instance = user.task_list.first
      instance.complete!
      visit root_path
      click_link instance.task.name
      expect(page).to have_current_path(root_path, ignore_query: true)
      expect(instance.reload.completed?).to be(false)
    end

    scenario 'add xp on task completion' do
      old_xp   = user.xp
      instance = user.task_list.first
      visit root_path
      click_link instance.task.name
      expect(user.reload.xp).to be > old_xp
    end

    scenario 'remove xp on task uncompletion' do
      instance = user.task_list.first
      instance.complete!
      old_xp   = user.reload.xp
      visit root_path
      click_link instance.task.name
      expect(user.reload.xp).to be < old_xp
    end
  end
end
