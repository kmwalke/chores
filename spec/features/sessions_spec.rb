require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  scenario 'redirects to requested admin page' do
    visit admin_users_path
    expect(current_path).to eq(login_path)
    login
    expect(current_path).to eq(admin_users_path)
  end

  describe 'logged out' do
    scenario 'login link' do
      visit root_path
      click_link 'Log In'
      expect(current_path).to eq(login_path)
    end
  end

  describe 'logged in' do
    before :each do
      login
    end

    scenario 'logs in' do
      expect(page).to have_content('Log Out')
      expect(current_path).to eq(root_path)
    end

    scenario 'logs out' do
      logout
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Log In')
    end
  end
end
