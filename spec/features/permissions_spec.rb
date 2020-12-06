require 'rails_helper'

RSpec.feature 'Permissions', type: :feature do
  # describe 'logged out' do
  #   scenario 'must be logged in to manage permissions' do
  #     visit permissions_path
  #     expect(current_path).to eq(login_path)
  #   end
  # end

  describe 'logged in' do
    let!(:permission) { Permission.create(name: 'permission1', description: 'Feature One') }

    # before :each do
    #   login
    # end

    scenario 'list permissions' do
      visit permissions_path
      expect(page).to have_content(permission.name)
    end

    scenario 'create a permission' do
      permission2 = Permission.new(name: 'permission2', description: 'Feature Two')
      visit permissions_path

      click_link 'New Permission'
      fill_in_form(permission2)
      click_button 'Create Permission'

      expect(current_path).to eq(permissions_path)
      expect(page).to have_content(permission2.name)
    end

    scenario 'edit a permission' do
      visit permissions_path

      click_link permission.name
      permission.name = 'new name'
      fill_in_form(permission)
      click_button 'Update Permission'

      expect(current_path).to eq(permissions_path)
      expect(page).to have_content(permission.name)
    end

    scenario 'delete a permission' do
      permission_id = permission.id
      visit permissions_path

      click_link "delete_#{permission.id}"
      expect(current_path).to eq(permissions_path)
      expect(Permission.find_by_id(permission_id)).to be_nil
    end
  end

  def fill_in_form(permission)
    fill_in 'Name', with: permission.name
    fill_in 'Description', with: permission.description
  end
end
