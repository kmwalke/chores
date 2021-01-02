require 'rails_helper'

RSpec.feature 'Navigation', type: :feature do
  describe 'logged out' do
    scenario 'logs in' do
      visit root_path
      click_link 'Log In'
      expect(current_path).to eq(login_path)
    end
  end

  describe 'logged in with no permissions' do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      login(user)
      visit root_path
    end

    scenario 'logs out' do
      click_link 'Log Out'
      expect(current_path).to eq(root_path)
    end
  end

  describe 'logged in with permissions' do
    let(:user) { FactoryBot.create(:user, role: FactoryBot.create(:role_admin)) }

    before(:each) do
      login(user)
      visit root_path
    end

    scenario 'visits My Account' do
      click_link 'My Account'
      expect(current_path).to eq(edit_current_user_path)
    end

    scenario 'visits rewards' do
      click_link 'Rewards'
      expect(current_path).to eq(rewards_path)
    end

    scenario 'visits tasks' do
      click_link 'Tasks'
      expect(current_path).to eq(tasks_path)
    end

    scenario 'visits features' do
      click_link 'Features'
      expect(current_path).to eq(features_path)
    end

    scenario 'visits permissions' do
      click_link 'Permissions'
      expect(current_path).to eq(permissions_path)
    end

    scenario 'visits roles' do
      click_link 'Roles'
      expect(current_path).to eq(roles_path)
    end

    scenario 'visits users' do
      click_link 'Users'
      expect(current_path).to eq(users_path)
    end
  end
end
