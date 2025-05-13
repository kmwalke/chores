require 'rails_helper'

RSpec.feature 'Features', type: :feature do
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

  scenario 'create a feature' do
    feature2 = build(:feature)
    visit features_path

    click_link 'New Feature'
    fill_in_form(feature2)
    click_button 'Create Feature'

    expect(page).to have_current_path(features_path, ignore_query: true)
    expect(page).to have_content(feature2.name)
  end

  scenario 'edit a feature' do
    visit features_path

    click_link feature.name
    feature.name = 'new name'
    fill_in_form(feature)
    click_button 'Update Feature'

    expect(page).to have_current_path(features_path, ignore_query: true)
    expect(page).to have_content(feature.name)
  end

  scenario 'delete a feature' do
    feature_id = feature.id
    visit features_path

    click_link "delete_#{feature.id}"
    expect(page).to have_current_path(features_path, ignore_query: true)
    expect(Feature.find_by(id: feature_id)).to be_nil
  end

  def fill_in_form(feature)
    fill_in 'Name', with: feature.name
  end
end
