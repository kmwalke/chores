require 'rails_helper'

RSpec.feature 'Current User' do
  describe 'logged out' do
    scenario 'displays the homepage' do
      visit edit_current_user_path
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe 'logged in' do
    let(:user) { create(:user, role: create(:role_admin)) }

    before do
      login(user)
    end

    describe 'displays edit page' do
      before do
        visit edit_current_user_path
      end

      scenario 'shows the edit page' do
        expect(page).to have_current_path(edit_current_user_path, ignore_query: true)
      end

      scenario 'lists user name' do
        expect(page).to have_content(user.name)
      end
    end

    describe 'edits current user' do
      let(:new_name) { 'this is my new name' }

      before do
        visit edit_current_user_path
        fill_in 'Name', with: new_name
        click_button 'Save changes'
      end

      scenario 'redirects to root' do
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      scenario 'saves new name' do
        expect(user.reload.name).to eq(new_name)
      end
    end

    describe 'does not delete current user if form not filled' do
      let!(:user_id) { user.id }

      before do
        visit edit_current_user_path
        click_link 'Delete User'
      end

      scenario 'redirects to delete page' do
        expect(page).to have_current_path(delete_current_user_path, ignore_query: true)
      end

      describe 'doesnt actually delete' do
        before do
          fill_in 'Confirm', with: 'not a name'
          click_button 'Delete My Account & All of My Data'
        end

        scenario 'redirects to edit page' do
          expect(page).to have_current_path(edit_current_user_path, ignore_query: true)
        end

        scenario 'didnt delete the user' do
          expect(User.find(user_id)).to eq(user)
        end
      end

      describe 'does actually delete' do
        before do
          fill_in 'Confirm', with: user.name
          click_button 'Delete My Account & All of My Data'
        end

        scenario 'redirects to root' do
          expect(page).to have_current_path(root_path, ignore_query: true)
        end

        scenario 'deletes the user' do
          expect(User.find_by(id: user_id)).to be_nil
        end
      end
    end
  end
end
