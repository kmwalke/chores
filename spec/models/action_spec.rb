require 'rails_helper'

RSpec.describe Action, type: :model do
  it 'should require a name' do
    expect(Action.create(name: '').errors).to have_key(:name)
  end

  it 'should require a unique name' do
    expect(Action.create(name: FactoryBot.create(:action).name).errors).to have_key(:name)
  end
end
