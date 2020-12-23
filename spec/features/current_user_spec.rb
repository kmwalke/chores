require 'rails_helper'

RSpec.feature 'Current User', type: :feature do
  describe 'logged out' do
    scenario 'displays the homepage' do
      visit edit_current_user_path
      expect(current_path).to eq(root_path)
    end
  end

  describe 'logged in' do
    let(:user) { FactoryBot.create(:user, role: FactoryBot.create(:role_admin)) }

    before(:each) do
      login(user)
    end

    scenario 'displays edit page' do
      visit edit_current_user_path
      expect(current_path).to eq(edit_current_user_path)
      expect(page).to have_content(user.name)
    end

    scenario 'edits current user' do
      new_name = 'this is my new name'
      visit edit_current_user_path
      fill_in 'Name', with: new_name
      click_button 'Save changes'

      expect(current_path).to eq(root_path)
      expect(user.reload.name).to eq(new_name)
    end

    scenario 'does not delete current user if form not filled' do
      user_id = user.id
      visit edit_current_user_path

      click_link 'Delete User'
      expect(current_path).to eq(delete_current_user_path)

      fill_in 'Confirm', with: 'not a name'
      click_button 'Delete My Account & All of My Data'
      expect(current_path).to eq(edit_current_user_path)
      expect(User.find(user_id)).to eq(user)
    end

    scenario 'deletes current user' do
      user_id = user.id
      visit edit_current_user_path

      click_link 'Delete User'
      expect(current_path).to eq(delete_current_user_path)

      fill_in 'Confirm', with: user.name
      click_button 'Delete My Account & All of My Data'
      expect(current_path).to eq(root_path)
      expect(User.find_by_id(user_id)).to be_nil
    end
  end
end
