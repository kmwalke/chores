require 'rails_helper'

RSpec.feature 'Users' do
  let!(:user) { create(:user) }
  let(:admin) { create(:user, role: create(:role_admin)) }

  before do
    login(admin)
  end

  describe 'list users' do
    before do
      visit users_path
    end

    scenario 'list users name' do
      expect(page).to have_content(user.name)
    end

    scenario 'list users email' do
      expect(page).to have_content(user.email)
    end
  end

  describe 'create a user' do
    let!(:user2) { build(:user, role: user.role) }

    before do
      visit users_path

      click_link 'New User'
      fill_in_form(user2)
      click_button 'Create User'
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(users_path, ignore_query: true)
    end

    scenario 'lists the new user' do
      expect(page).to have_content(user2.name)
    end
  end

  describe scenario 'edit a user' do
    before do
      visit users_path

      click_link user.name
      user.name = 'new name'
      fill_in_form(user)
      click_button 'Update User'
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(users_path, ignore_query: true)
    end

    scenario 'lists new user name' do
      expect(page).to have_content(user.name)
    end
  end

  describe 'delete a user' do
    let!(:user2) { create(:user) }
    let(:user2_id) { user2.id }

    before do
      visit users_path

      click_link "delete_#{user2.id}"
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(users_path, ignore_query: true)
    end

    scenario 'deletes old user' do
      expect(User.find_by(id: user2_id)).to be_nil
    end
  end

  def fill_in_form(user)
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    select user.time_zone, from: 'user[time_zone]'
    select user.role.name, from: 'user[role_id]'
  end
end
