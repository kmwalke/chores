require 'rails_helper'

RSpec.describe Permission, type: :model do
  it 'should require a feature' do
    expect(Permission.create(feature: nil).errors).to have_key(:feature)
  end

  it 'should have actions' do
    p = FactoryBot.create(:permission)
    a = FactoryBot.create(:action)
    p.actions << a

    expect(p.reload.actions.include?(a)).to eq(true)
  end

  it 'should have roles' do
    p = FactoryBot.create(:permission)
    r = FactoryBot.create(:role)
    p.roles << r

    expect(p.reload.roles.include?(r)).to eq(true)
  end
end
