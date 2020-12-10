require 'rails_helper'

RSpec.feature 'Access Control', type: :feature do
  describe 'logged out' do
    # TODO: Stub a controller instead of using a specific one
    scenario 'must be logged in to manage users' do
      visit users_path
      expect(current_path).to eq(root_path)
    end
  end

  describe 'logged in' do
    let(:feature) { FactoryBot.create(:feature) }

    # TODO: Stub a controller instead of using a specific one
    describe 'unauthorized' do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user) }

      before :each do
        login(user)
      end

      scenario 'cannot visit index' do
        visit users_path
        expect(current_path).to eq(root_path)
      end

      scenario 'cannot visit show' do
        visit user_path(other_user)
        expect(current_path).to eq(root_path)
      end

      scenario 'can visit edit' do
        visit edit_user_path(other_user)
        expect(current_path).to eq(root_path)
      end
    end

    describe 'admin authorized' do
      let(:user) { FactoryBot.create(:user) }
      let!(:admin) do
        FactoryBot.create(
          :user,
          role: FactoryBot.create(
            :role,
            permissions: [
              FactoryBot.create(
                :permission,
                feature: Feature.find_by(name: 'users')
              )
            ]
          )
        )
      end

      before :each do
        login(admin)
      end

      scenario 'can visit index' do
        visit users_path
        expect(current_path).to eq(users_path)
      end

      scenario 'can visit show' do
        visit user_path(user)
        expect(current_path).to eq(user_path(user))
      end

      scenario 'can visit edit' do
        visit edit_user_path(user)
        expect(current_path).to eq(edit_user_path(user))
      end
    end

    describe 'partial authorized' do
      let(:user) { FactoryBot.create(:user) }
      let!(:partial_user) do
        FactoryBot.create(
          :user,
          role: FactoryBot.create(
            :role,
            permissions: [
              FactoryBot.create(
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

      before :each do
        login(partial_user)
      end

      scenario 'can visit index' do
        visit users_path
        expect(current_path).to eq(users_path)
      end

      scenario 'can visit show' do
        visit user_path(user)
        expect(current_path).to eq(user_path(user))
      end

      scenario 'cannot visit edit' do
        visit edit_user_path(user)
        expect(current_path).to eq(root_path)
      end
    end
  end
end
