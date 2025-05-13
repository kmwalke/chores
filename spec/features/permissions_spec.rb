require 'rails_helper'

RSpec.feature 'Permissions' do
  let!(:permission) { create(:permission) }
  let(:admin) { create(:user, role: create(:role_admin)) }

  before do
    login(admin)
  end

  scenario 'list permissions' do
    visit permissions_path
    expect(page).to have_content(permission.feature.name)
  end

  describe 'create a permission' do
    let!(:permission2) { build(:permission, feature: create(:feature), actions: permission.actions) }

    before do
      visit permissions_path

      click_link 'New Permission'
      fill_in_form(permission2)
      click_button 'Create Permission'
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(permissions_path, ignore_query: true)
    end

    scenario 'lists new permission' do
      expect(page).to have_content(permission2.feature.name)
    end
  end

  describe 'edit a permission' do
    before do
      visit permissions_path

      click_link permission.feature.name
      permission.feature = create(:feature)
      fill_in_form(permission.reload)
      click_button 'Update Permission'
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(permissions_path, ignore_query: true)
    end

    scenario 'lists new permission' do
      expect(page).to have_content(permission.reload.feature.name)
    end
  end

  describe 'delete a permission' do
    let(:permission_id) { permission.id }

    before do
      visit permissions_path

      click_link "delete_#{permission.id}"
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(permissions_path, ignore_query: true)
    end

    scenario 'removes old permission' do
      expect(Permission.find_by(id: permission_id)).to be_nil
    end
  end

  def fill_in_form(permission)
    select permission.feature.name, from: 'permission[feature_id]'
    permission.actions.each do |action|
      check action.name
    end
  end
end
