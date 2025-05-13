require 'rails_helper'

RSpec.describe Reward, type: :model do
  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  it 'requires a user' do
    expect(described_class.create(user_id: nil).errors).to have_key(:user_id)
  end

  it 'generates an abbreviation' do
    name = 'name of reward'
    expect(create(:reward, name: name).abbreviation).to eq(name[0..1])
  end
end
