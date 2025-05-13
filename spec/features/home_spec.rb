require 'rails_helper'

RSpec.feature 'Home' do
  describe 'logged out' do
    before do
      visit root_path
    end

    scenario 'displays the log in link' do
      expect(page).to have_content('Log In')
    end

    scenario 'doesnt show tasks' do
      expect(page).to have_no_content('Tasks')
    end
  end

  describe 'logged in with no tasks' do
    let(:user) { create(:user) }

    before do
      login(user)
      visit root_path
    end

    scenario 'displays the user avatar' do
      expect(page).to have_content(user.avatar)
    end

    scenario 'displays the task link' do
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

    describe 'displays the homepage' do
      before do
        visit root_path
      end

      scenario 'shows next reward' do
        expect(page).to have_content(user.next_reward.abbreviation)
      end

      scenario 'lists tasks' do
        user.task_list.each do |item|
          expect(page).to have_content(item.task.name)
        end
      end

      scenario 'lists rewards' do
        user.earned_rewards.each do |reward|
          expect(page).to have_content(reward.name)
        end
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

    describe 'completes a task' do
      let!(:instance) { user.task_list.first }

      before do
        visit root_path
        click_link instance.task.name
      end

      scenario 'redirects to root' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      scenario 'completes task' do
        expect(instance.reload.completed?).to be(true)
      end
    end

    describe 'uncompletes a task' do
      let!(:instance) { user.task_list.first }

      before do
        instance.complete!
        visit root_path
        click_link instance.task.name
      end

      scenario 'redirects to root' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      scenario 'uncompletes the task' do
        expect(instance.reload.completed?).to be(false)
      end
    end

    scenario 'add xp on task completion' do
      old_xp   = user.xp
      instance = user.task_list.first
      visit root_path
      click_link instance.task.name
      expect(user.reload.xp).to be > old_xp
    end

    describe 'remove xp on task uncompletion' do
      let!(:instance) { user.task_list.first }

      scenario 'recalculates xp' do
        instance.complete!
        old_xp = user.reload.xp
        visit root_path
        click_link instance.task.name
        expect(user.reload.xp).to be < old_xp
      end
    end
  end
end
