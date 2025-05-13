require 'rails_helper'

RSpec.feature 'Rewards', type: :feature do
  let(:admin) { create(:user, role: create(:role_admin)) }
  let!(:reward) { create(:reward, user: admin) }
  let(:user) { create(:user) }
  let!(:user_reward) { create(:reward, user: user) }

  before do
    login(admin)
  end

  scenario 'list my rewards' do
    visit rewards_path
    expect(page).to have_content(reward.name)
  end

  scenario 'not list other\'s rewards' do
    visit rewards_path
    expect(page).to have_no_content(user_reward.name)
  end

  scenario 'show a reward' do
    visit reward_path(reward)
    expect(page).to have_content(reward.name)
  end

  scenario 'not show another\'s reward' do
    visit reward_path(user_reward)
    expect(page).to have_current_path(rewards_path, ignore_query: true)
  end

  scenario 'create a reward' do
    reward2 = build(:reward)
    visit rewards_path

    click_link 'New Reward'
    fill_in_form(reward2)
    click_button 'Create Reward'

    expect(page).to have_current_path(rewards_path, ignore_query: true)
    expect(page).to have_content(reward2.name)
    expect(Reward.find_by(name: reward2.name).user).to eq(admin)
  end

  scenario 'edit a reward' do
    visit rewards_path

    click_link reward.name
    reward.name = 'new name'
    fill_in_form(reward)
    click_button 'Update Reward'

    expect(page).to have_current_path(rewards_path, ignore_query: true)
    expect(page).to have_content(reward.name)
  end

  scenario 'not edit another\'s reward' do
    visit edit_reward_path(user_reward)
    expect(page).to have_current_path(rewards_path, ignore_query: true)
  end

  scenario 'delete a reward' do
    reward_id = reward.id
    visit rewards_path

    click_link "delete_#{reward.id}"
    expect(page).to have_current_path(rewards_path, ignore_query: true)
    expect(Reward.find_by(id: reward_id)).to be_nil
  end

  def fill_in_form(reward)
    fill_in 'Name', with: reward.name
  end
end
