require 'rails_helper'

RSpec.feature 'Permissions', type: :feature do
  let!(:permission) { FactoryBot.create(:permission) }
  let(:admin) { FactoryBot.create(:user, role: FactoryBot.create(:role_admin)) }

  before :each do
    login(admin)
  end

  scenario 'list permissions' do
    visit permissions_path
    expect(page).to have_content(permission.feature.name)
  end

  scenario 'create a permission' do
    permission2 = FactoryBot.build(:permission, feature: FactoryBot.create(:feature), actions: permission.actions)
    visit permissions_path

    click_link 'New Permission'
    fill_in_form(permission2)
    click_button 'Create Permission'

    expect(current_path).to eq(permissions_path)
    expect(page).to have_content(permission2.feature.name)
  end

  scenario 'edit a permission' do
    visit permissions_path

    click_link permission.feature.name
    permission.feature = FactoryBot.create(:feature)
    fill_in_form(permission.reload)
    click_button 'Update Permission'

    expect(current_path).to eq(permissions_path)
    expect(page).to have_content(permission.reload.feature.name)
  end

  scenario 'delete a permission' do
    permission_id = permission.id
    visit permissions_path

    click_link "delete_#{permission.id}"
    expect(current_path).to eq(permissions_path)
    expect(Permission.find_by_id(permission_id)).to be_nil
  end

  def fill_in_form(permission)
    select permission.feature.name, from: 'permission[feature_id]'
    permission.actions.each do |action|
      check action.name
    end
  end
end
