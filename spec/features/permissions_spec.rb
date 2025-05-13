require 'rails_helper'

RSpec.feature 'Permissions', type: :feature do
  let!(:permission) { create(:permission) }
  let(:admin) { create(:user, role: create(:role_admin)) }

  before do
    login(admin)
  end

  scenario 'list permissions' do
    visit permissions_path
    expect(page).to have_content(permission.feature.name)
  end

  scenario 'create a permission' do
    permission2 = build(:permission, feature: create(:feature), actions: permission.actions)
    visit permissions_path

    click_link 'New Permission'
    fill_in_form(permission2)
    click_button 'Create Permission'

    expect(page).to have_current_path(permissions_path, ignore_query: true)
    expect(page).to have_content(permission2.feature.name)
  end

  scenario 'edit a permission' do
    visit permissions_path

    click_link permission.feature.name
    permission.feature = create(:feature)
    fill_in_form(permission.reload)
    click_button 'Update Permission'

    expect(page).to have_current_path(permissions_path, ignore_query: true)
    expect(page).to have_content(permission.reload.feature.name)
  end

  scenario 'delete a permission' do
    permission_id = permission.id
    visit permissions_path

    click_link "delete_#{permission.id}"
    expect(page).to have_current_path(permissions_path, ignore_query: true)
    expect(Permission.find_by(id: permission_id)).to be_nil
  end

  def fill_in_form(permission)
    select permission.feature.name, from: 'permission[feature_id]'
    permission.actions.each do |action|
      check action.name
    end
  end
end
