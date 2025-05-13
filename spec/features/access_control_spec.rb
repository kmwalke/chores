require 'rails_helper'

RSpec.feature 'Access Control' do
  describe 'logged out' do
    # TODO: Stub a controller instead of using a specific one
    scenario 'must be logged in to manage users' do
      visit users_path
      expect(page).to have_current_path(root_path, ignore_query: true)
    end
  end

  describe 'logged in' do
    let(:feature) { create(:feature) }

    # TODO: Stub a controller instead of using a specific one
    describe 'unauthorized' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      before do
        login(user)
      end

      scenario 'cannot visit index' do
        visit users_path
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      scenario 'cannot visit show' do
        visit user_path(other_user)
        expect(page).to have_current_path(root_path, ignore_query: true)
      end

      scenario 'can visit edit' do
        visit edit_user_path(other_user)
        expect(page).to have_current_path(root_path, ignore_query: true)
      end
    end

    describe 'admin authorized' do
      let(:user) { create(:user) }
      let!(:admin) do
        create(
          :user,
          role: create(:role_admin)
        )
      end

      before do
        login(admin)
      end

      scenario 'can visit index' do
        visit users_path
        expect(page).to have_current_path(users_path, ignore_query: true)
      end

      scenario 'can visit show' do
        visit user_path(user)
        expect(page).to have_current_path(user_path(user), ignore_query: true)
      end

      scenario 'can visit edit' do
        visit edit_user_path(user)
        expect(page).to have_current_path(edit_user_path(user), ignore_query: true)
      end
    end

    describe 'partial authorized' do
      let(:user) { create(:user) }
      let!(:partial_user) do
        create(
          :user,
          role: create(
            :role,
            permissions: [
              create(
                :permission,
                feature: Feature.find_by(name: 'users'),
                actions: [
                  Action.find_by(name: Action::INDEX),
                  Action.find_by(name: Action::SHOW)
                ]
              )
            ]
          )
        )
      end

      before do
        login(partial_user)
      end

      scenario 'can visit index' do
        visit users_path
        expect(page).to have_current_path(users_path, ignore_query: true)
      end

      scenario 'can visit show' do
        visit user_path(user)
        expect(page).to have_current_path(user_path(user), ignore_query: true)
      end

      scenario 'cannot visit edit' do
        visit edit_user_path(user)
        expect(page).to have_current_path(root_path, ignore_query: true)
      end
    end
  end
end
