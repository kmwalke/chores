require 'rails_helper'

RSpec.feature 'Access Control', type: :feature do
  describe 'logged in' do
    let(:feature) { FactoryBot.create(:feature) }
    let(:admin) { FactoryBot.create(:user) }

    describe 'unauthorized' do
      let(:user) { FactoryBot.create(:user) }

      scenario 'cannot list features' do
        expect(true).to eq(false)
        # Check each action.  Should this be in sessions_spec?  Or a new access_control_spec?
      end
    end
  end
end
