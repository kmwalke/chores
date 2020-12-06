require 'rails_helper'

RSpec.feature 'Roles', type: :feature do
  describe 'logged out', skip: 'not implemented' do
    scenario 'must be logged in to manage roles' do
      visit roles_path
      expect(current_path).to eq(login_path)
    end
  end

  describe 'logged in' do
    let!(:role) { Role.create(name: 'role1') }

    before :each, skip: 'not implemented' do
      login
    end

    before :each do
    end

    scenario 'list roles' do
      visit roles_path
      expect(page).to have_content(role.name)
    end

    scenario 'show a role' do
      role.permissions << Permission.create(name: 'feature1', description: 'Feature One')
      role.permissions << Permission.create(name: 'feature2', description: 'Feature Two')

      visit role_path(role)
      expect(page).to have_content(role.name)
      role.permissions.each do |permission|
        expect(page).to have_content(permission.name)
      end
    end

    scenario 'create a role' do
      role2 = Role.new(name: 'role2', description: 'Feature Two')
      role2.permissions << Permission.create(name: 'feature1', description: 'Feature One')
      role2.permissions << Permission.create(name: 'feature2', description: 'Feature Two')
      visit roles_path

      click_link 'New Role'
      fill_in_form(role2)
      click_button 'Create Role'

      expect(current_path).to eq(roles_path)
      expect(page).to have_content(role2.name)
    end

    scenario 'edit a role' do
      visit roles_path

      click_link role.name
      role.name = 'new name'
      fill_in_form(role)
      click_button 'Update Role'

      expect(current_path).to eq(roles_path)
      expect(page).to have_content(role.name)
    end

    scenario 'delete a role' do
      role_id = role.id
      visit roles_path

      click_link "delete_#{role.id}"
      expect(current_path).to eq(roles_path)
      expect(Role.find_by_id(role_id)).to be_nil
    end
  end

  def fill_in_form(role)
    fill_in 'Name', with: role.name
    fill_in 'Description', with: role.description
    role.permissions.each do |permission|
      check permission.name
    end
  end
end
