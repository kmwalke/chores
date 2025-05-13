require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  let(:user) { create(:user) }

  scenario 'redirects to requested admin page', skip: 'not implemented' do
    visit users_path
    expect(page).to have_current_path(login_path, ignore_query: true)
    login(user)
    expect(page).to have_current_path(users_path, ignore_query: true)
  end

  describe 'logged out' do
    scenario 'login link' do
      visit root_path
      click_link 'Log In'
      expect(page).to have_current_path(login_path, ignore_query: true)
    end
  end

  describe 'logging in' do
    scenario 'case insensitive email' do
      visit login_path
      fill_in 'Email', with: user.email.upcase
      fill_in 'Password', with: user.password
      click_button 'Log In'
      expect(page).to have_content('Log Out')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    scenario 'email with spaces' do
      visit login_path
      fill_in 'Email', with: " #{user.email} "
      fill_in 'Password', with: user.password
      click_button 'Log In'
      expect(page).to have_content('Log Out')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    scenario 'Wrong Password' do
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'Wrong Password'
      click_button 'Log In'
      expect(page).to have_content('Email or password is invalid')
      expect(page).to have_current_path(sessions_path, ignore_query: true)
    end

    scenario 'Wrong Email' do
      visit login_path
      fill_in 'Email', with: 'Wrong Email'
      fill_in 'Password', with: user.password
      click_button 'Log In'
      expect(page).to have_content('Email or password is invalid')
      expect(page).to have_current_path(sessions_path, ignore_query: true)
    end
  end

  describe 'logged in' do
    before do
      login(user)
    end

    scenario 'logs in' do
      expect(page).to have_content('Log Out')
      expect(page).to have_current_path(root_path, ignore_query: true)
    end

    scenario 'logs out' do
      logout
      expect(page).to have_current_path(root_path, ignore_query: true)
      expect(page).to have_content('Log In')
    end
  end
end
