require 'rails_helper'

RSpec.feature 'Features', type: :feature do
  let!(:feature) { FactoryBot.create(:feature) }
  let(:admin) { FactoryBot.create(:user) }

  before :each do
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
    feature2 = FactoryBot.build(:feature)
    visit features_path

    click_link 'New Feature'
    fill_in_form(feature2)
    click_button 'Create Feature'

    expect(current_path).to eq(features_path)
    expect(page).to have_content(feature2.name)
  end

  scenario 'edit a feature' do
    visit features_path

    click_link feature.name
    feature.name = 'new name'
    fill_in_form(feature)
    click_button 'Update Feature'

    expect(current_path).to eq(features_path)
    expect(page).to have_content(feature.name)
  end

  scenario 'delete a feature' do
    feature_id = feature.id
    visit features_path

    click_link "delete_#{feature.id}"
    expect(current_path).to eq(features_path)
    expect(Feature.find_by_id(feature_id)).to be_nil
  end
end

def fill_in_form(feature)
  fill_in 'Name', with: feature.name
end
