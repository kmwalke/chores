require 'rails_helper'

RSpec.feature 'Roles' do
  let!(:role) { create(:role) }
  let(:admin) { create(:user, role: create(:role_admin)) }

  before do
    login(admin)
  end

  scenario 'list roles' do
    visit roles_path
    expect(page).to have_content(role.name)
  end

  describe 'show a role' do
    before do
      role.permissions << create(:permission)
      role.permissions << create(:permission)

      visit role_path(role)
    end

    scenario 'lists role name' do
      expect(page).to have_content(role.name)
    end

    scenario 'each permission gets feature' do
      role.permissions.each do |permission|
        expect(page).to have_content(permission.feature.name)
      end
    end
  end

  describe 'create a role' do
    let(:role2) { build(:role, permissions: role.permissions) }

    before do
      visit roles_path

      click_link 'New Role'
      fill_in_form(role2)
      click_button 'Create Role'
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(roles_path, ignore_query: true)
    end

    scenario 'lists new name' do
      expect(page).to have_content(role2.name)
    end
  end

  describe 'edit a role' do
    before do
      visit roles_path

      click_link role.name
      role.name = 'new name'
      fill_in_form(role)
      click_button 'Update Role'
    end

    scenario 'redirect to index' do
      expect(page).to have_current_path(roles_path, ignore_query: true)
    end

    scenario 'lists new name' do
      expect(page).to have_content(role.name)
    end
  end

  describe 'delete a role' do
    let(:role_id) { role.id }

    before do
      visit roles_path

      click_link "delete_#{role.id}"
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(roles_path, ignore_query: true)
    end

    scenario 'removes old role' do
      expect(Role.find_by(id: role_id)).to be_nil
    end
  end

  def fill_in_form(role)
    fill_in 'Name', with: role.name
    fill_in 'Description', with: role.description
    role.permissions.each do |permission|
      check "role_permission_ids_#{permission.id}"
    end
  end
end
