require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let!(:user) { create(:user) }
  let(:admin) { create(:user, role: create(:role_admin)) }

  before do
    login(admin)
  end

  scenario 'list users' do
    visit users_path
    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end

  scenario 'create a user' do
    user2 = build(:user, role: user.role)
    visit users_path

    click_link 'New User'
    fill_in_form(user2)
    click_button 'Create User'

    expect(page).to have_current_path(users_path, ignore_query: true)
    expect(page).to have_content(user2.name)
  end

  scenario 'edit a user' do
    visit users_path

    click_link user.name
    user.name = 'new name'
    fill_in_form(user)
    click_button 'Update User'

    expect(page).to have_current_path(users_path, ignore_query: true)
    expect(page).to have_content(user.name)
  end

  scenario 'delete a user' do
    user2    = create(:user)
    user2_id = user2.id
    visit users_path

    click_link "delete_#{user2.id}"
    expect(page).to have_current_path(users_path, ignore_query: true)
    expect(User.find_by(id: user2_id)).to be_nil
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
