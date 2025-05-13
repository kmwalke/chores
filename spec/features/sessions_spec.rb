require 'rails_helper'

RSpec.feature 'Sessions' do
  let(:user) { create(:user) }

  describe 'redirects to requested admin page', skip: 'not implemented' do
    before do
      visit users_path
    end

    scenario 'redirect to login page' do
      expect(page).to have_current_path(login_path, ignore_query: true)
    end

    scenario 'logs in and sent to original page' do
      login(user)
      expect(page).to have_current_path(users_path, ignore_query: true)
    end
  end

  describe 'logged out' do
    scenario 'login link' do
      visit root_path
      click_link 'Log In'
      expect(page).to have_current_path(login_path, ignore_query: true)
    end
  end

  describe 'logging in oddly' do
    before do
      visit login_path
    end

    describe 'case insensitive email' do
      before do
        fill_in 'Email', with: user.email.upcase
        fill_in 'Password', with: user.password
        click_button 'Log In'
      end

      scenario 'displays log out link' do
        expect(page).to have_content('Log Out')
      end

      scenario 'redirects to root' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end
    end

    describe 'email with spaces' do
      before do
        fill_in 'Email', with: " #{user.email} "
        fill_in 'Password', with: user.password
        click_button 'Log In'
      end

      scenario 'displays log out link' do
        expect(page).to have_content('Log Out')
      end

      scenario 'redirects to root' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end
    end

    describe 'Wrong Password' do
      before do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'Wrong Password'
        click_button 'Log In'
      end

      scenario 'displays error' do
        expect(page).to have_content('Email or password is invalid')
      end

      scenario 'redirects to login page' do
        expect(page).to have_current_path(sessions_path, ignore_query: true)
      end
    end

    describe 'Wrong Email' do
      before do
        fill_in 'Email', with: 'Wrong Email'
        fill_in 'Password', with: user.password
        click_button 'Log In'
      end

      scenario 'displays error' do
        expect(page).to have_content('Email or password is invalid')
      end

      scenario 'redirects to login page' do
        expect(page).to have_current_path(sessions_path, ignore_query: true)
      end
    end
  end

  describe 'log in normally' do
    before do
      login(user)
    end

    describe 'logs in' do
      scenario 'displays log out link' do
        expect(page).to have_content('Log Out')
      end

      scenario 'redirects to root' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end
    end

    describe 'logs out' do
      before do
        logout
      end

      scenario 'redirects to root' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      scenario 'displays login link' do
        expect(page).to have_content('Log In')
      end
    end
  end
end
