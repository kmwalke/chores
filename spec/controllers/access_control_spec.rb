require 'rails_helper'

RSpec.describe UsersController do
  describe 'logged out' do
    # TODO: Stub a controller instead of using a specific one
    scenario 'must be logged in to manage users' do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'logged in' do
    let(:feature) { FactoryBot.create(:feature) }

    # TODO: Stub a controller instead of using a specific one
    describe 'unauthorized' do
      let(:user) { FactoryBot.create(:user) }

      before :each do
        login(user)
      end

      scenario 'cannot list users' do
        visit users_path
        expect(current_path).to eq(root_path)
      end
    end

    describe 'authorized' do
      let!(:admin) do
        FactoryBot.create(
          :user,
          role: FactoryBot.create(
            :role,
            permissions: [
              FactoryBot.create(
                :permission,
                feature: FactoryBot.create(
                  :feature,
                  name: 'users'
                ),
                actions: [
                  FactoryBot.create(:action, name: Action::CREATE),
                  FactoryBot.create(:action, name: Action::INDEX),
                  FactoryBot.create(:action, name: Action::UPDATE),
                  FactoryBot.create(:action, name: Action::DESTROY),
                ]
              )
            ]
          )
        )
      end

      before :each do
        login(admin)
      end

      scenario 'can list users' do
        visit users_path
        expect(current_path).to eq(users_path)
      end
    end
  end
end
