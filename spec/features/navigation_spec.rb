require 'rails_helper'

RSpec.feature 'Navigation' do
  describe 'logged out' do
    scenario 'logs in' do
      visit root_path
      click_link 'Log In'
      expect(page).to have_current_path(login_path, ignore_query: true)
    end
  end

  describe 'logged in with no permissions' do
    let(:user) { create(:user) }

    before do
      login(user)
      visit root_path
    end

    scenario 'logs out' do
      click_link 'Log Out'
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe 'logged in with permissions' do
    let(:user) { create(:user, role: create(:role_admin)) }

    before do
      login(user)
      visit root_path
    end

    scenario 'visits My Account' do
      click_link 'My Account'
      expect(page).to have_current_path(edit_current_user_path, ignore_query: true)
    end

    scenario 'visits rewards' do
      click_link 'Rewards'
      expect(page).to have_current_path(rewards_path, ignore_query: true)
    end

    scenario 'visits tasks' do
      click_link 'Tasks'
      expect(page).to have_current_path(tasks_path, ignore_query: true)
    end

    scenario 'visits features' do
      click_link 'Features'
      expect(page).to have_current_path(features_path, ignore_query: true)
    end

    scenario 'visits permissions' do
      click_link 'Permissions'
      expect(page).to have_current_path(permissions_path, ignore_query: true)
    end

    scenario 'visits roles' do
      click_link 'Roles'
      expect(page).to have_current_path(roles_path, ignore_query: true)
    end

    scenario 'visits users' do
      click_link 'Users'
      expect(page).to have_current_path(users_path, ignore_query: true)
    end
  end
end
