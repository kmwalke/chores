require 'rails_helper'

RSpec.describe Reward, type: :model do
  it 'should require a name' do
    expect(Reward.create(name: '').errors).to have_key(:name)
  end

  it 'should require a user' do
    expect(Reward.create(user_id: nil).errors).to have_key(:user_id)
  end

  it 'should generate an abbreviation' do
    name = 'name of reward'
    expect(FactoryBot.create(:reward, name: name).abbreviation).to eq(name[0..1])
  end
end
