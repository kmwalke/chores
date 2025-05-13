require 'rails_helper'

RSpec.feature 'Features' do
  let!(:feature) { create(:feature) }
  let(:admin) { create(:user, role: create(:role_admin)) }

  before do
    login(admin)
  end

  scenario 'list features' do
    visit features_path
    expect(page).to have_content(feature.name)
  end

  scenario 'show a feature' do
    visit feature_path(feature)
    expect(page).to have_content(feature.name)
  end

  describe 'create a feature' do
    let!(:feature2) { build(:feature) }

    before do
      visit features_path

      click_link 'New Feature'
      fill_in_form(feature2)
      click_button 'Create Feature'
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(features_path, ignore_query: true)
    end

    scenario 'lists the new feature' do
      expect(page).to have_content(feature2.name)
    end
  end

  describe 'edit a feature' do
    before do
      visit features_path

      click_link feature.name
      feature.name = 'new name'
      fill_in_form(feature)
      click_button 'Update Feature'
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(features_path, ignore_query: true)
    end

    scenario 'lists the new feature' do
      expect(page).to have_content(feature.name)
    end
  end

  describe 'delete a feature' do
    let!(:feature_id) { feature.id }

    before do
      visit features_path

      click_link "delete_#{feature.id}"
    end

    scenario 'redirects to index' do
      expect(page).to have_current_path(features_path, ignore_query: true)
    end

    scenario 'deletes old feature' do
      expect(Feature.find_by(id: feature_id)).to be_nil
    end
  end

  def fill_in_form(feature)
    fill_in 'Name', with: feature.name
  end
end
