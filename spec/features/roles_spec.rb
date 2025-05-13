require 'rails_helper'

RSpec.feature 'Roles', type: :feature do
  let!(:role) { create(:role) }
  let(:admin) { create(:user, role: create(:role_admin)) }

  before do
    login(admin)
  end

  scenario 'list roles' do
    visit roles_path
    expect(page).to have_content(role.name)
  end

  scenario 'show a role' do
    role.permissions << create(:permission)
    role.permissions << create(:permission)

    visit role_path(role)
    expect(page).to have_content(role.name)
    role.permissions.each do |permission|
      expect(page).to have_content(permission.feature.name)
    end
  end

  scenario 'create a role' do
    role2 = build(:role, permissions: role.permissions)
    visit roles_path

    click_link 'New Role'
    fill_in_form(role2)
    click_button 'Create Role'

    expect(page).to have_current_path(roles_path, ignore_query: true)
    expect(page).to have_content(role2.name)
  end

  scenario 'edit a role' do
    visit roles_path

    click_link role.name
    role.name = 'new name'
    fill_in_form(role)
    click_button 'Update Role'

    expect(page).to have_current_path(roles_path, ignore_query: true)
    expect(page).to have_content(role.name)
  end

  scenario 'delete a role' do
    role_id = role.id
    visit roles_path

    click_link "delete_#{role.id}"
    expect(page).to have_current_path(roles_path, ignore_query: true)
    expect(Role.find_by(id: role_id)).to be_nil
  end

  def fill_in_form(role)
    fill_in 'Name', with: role.name
    fill_in 'Description', with: role.description
    role.permissions.each do |permission|
      check "role_permission_ids_#{permission.id}"
    end
  end
end
