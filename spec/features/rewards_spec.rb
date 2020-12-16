require 'rails_helper'

RSpec.feature 'Rewards', type: :feature do
  let(:admin) { FactoryBot.create(:user, role: FactoryBot.create(:role_admin)) }
  let!(:reward) { FactoryBot.create(:reward, user: admin) }
  let(:user) { FactoryBot.create(:user) }
  let!(:user_reward) { FactoryBot.create(:reward, user: user) }

  before :each do
    login(admin)
  end

  scenario 'list my rewards' do
    visit rewards_path
    expect(page).to have_content(reward.name)
  end

  scenario 'not list other\'s rewards' do
    visit rewards_path
    expect(page).not_to have_content(user_reward.name)
  end

  scenario 'show a reward' do
    visit reward_path(reward)
    expect(page).to have_content(reward.name)
  end

  scenario 'not show another\'s reward' do
    visit reward_path(user_reward)
    expect(current_path).to eq(rewards_path)
  end

  scenario 'create a reward' do
    reward2 = FactoryBot.build(:reward)
    visit rewards_path

    click_link 'New Reward'
    fill_in_form(reward2)
    click_button 'Create Reward'

    expect(current_path).to eq(rewards_path)
    expect(page).to have_content(reward2.name)
    expect(Reward.find_by(name: reward2.name).user).to eq(admin)
  end

  scenario 'edit a reward' do
    visit rewards_path

    click_link reward.name
    reward.name = 'new name'
    fill_in_form(reward)
    click_button 'Update Reward'

    expect(current_path).to eq(rewards_path)
    expect(page).to have_content(reward.name)
  end

  scenario 'not edit another\'s reward' do
    visit edit_reward_path(user_reward)
    expect(current_path).to eq(rewards_path)
  end

  scenario 'delete a reward' do
    reward_id = reward.id
    visit rewards_path

    click_link "delete_#{reward.id}"
    expect(current_path).to eq(rewards_path)
    expect(Reward.find_by_id(reward_id)).to be_nil
  end

  def fill_in_form(reward)
    fill_in 'Name', with: reward.name
  end
end
