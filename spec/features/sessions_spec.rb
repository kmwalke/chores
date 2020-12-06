require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  scenario 'redirects to requested admin page', :skip do
    visit admin_users_path
    expect(current_path).to eq(login_path)
    login
    expect(current_path).to eq(admin_users_path)
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
      expect(page).not_to have_content('Log Out')
      expect(current_path).to eq(root_path)
    end
  end
end
