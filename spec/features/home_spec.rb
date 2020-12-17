require 'rails_helper'

RSpec.feature 'Home', type: :feature do
  scenario 'displays the homepage' do
    visit root_path

    expect(page).to have_content('Chores App')
  end
end
