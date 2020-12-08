require 'rails_helper'

RSpec.describe Feature, type: :model do
  it 'should require a name' do
    expect(Feature.create(name: '').errors).to have_key(:name)
  end

  it 'should require a unique name' do
    FactoryBot.create(:feature, name: 'name')
    expect(Feature.create(name: 'name').errors).to have_key(:name)
  end

  it 'should have permissions' do
    f = FactoryBot.create(:feature)
    p = FactoryBot.create(:permission)
    f.permissions << p

    expect(f.reload.permissions.first).to eq(p)
  end
end
