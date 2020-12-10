require 'rails_helper'

RSpec.feature 'Roles', type: :feature do
  let!(:role) { FactoryBot.create(:role) }
  let(:admin) { FactoryBot.create(:user, role: FactoryBot.create(:role_admin)) }

  before :each do
    login(admin)
  end

  scenario 'list roles' do
    visit roles_path
    expect(page).to have_content(role.name)
  end

  scenario 'show a role' do
    role.permissions << FactoryBot.create(:permission)
    role.permissions << FactoryBot.create(:permission)

    visit role_path(role)
    expect(page).to have_content(role.name)
    role.permissions.each do |permission|
      expect(page).to have_content(permission.feature.name)
    end
  end

  scenario 'create a role' do
    role2 = FactoryBot.build(:role, permissions: role.permissions)
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

  def fill_in_form(role)
    fill_in 'Name', with: role.name
    fill_in 'Description', with: role.description
    role.permissions.each do |permission|
      check "role_permission_ids_#{permission.id}"
    end
  end
end
