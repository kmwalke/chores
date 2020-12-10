require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  scenario 'redirects to requested admin page', skip: 'not implemented' do
    visit users_path
    expect(current_path).to eq(login_path)
    login(user)
    expect(current_path).to eq(users_path)
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
      login(user)
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
