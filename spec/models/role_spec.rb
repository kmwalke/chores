require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { FactoryBot.create(:role_admin) }

  it 'should require a name' do
    expect(Role.create(name: '').errors).to have_key(:name)
  end

  it 'should require a unique name' do
    expect(Role.create(name: FactoryBot.create(:role).name).errors).to have_key(:name)
  end

  it 'should have permissions' do
    p = FactoryBot.create(:permission)
    r = FactoryBot.create(:role)
    r.permissions << p

    expect(r.reload.permissions.include?(p)).to eq(true)
  end

  it 'has feature' do
    feature_name = role.permissions.first.feature.name
    expect(role.feature?(feature_name)).to eq(true)
  end

  it 'does not have feature' do
    feature_name = FactoryBot.create(:feature).name
    expect(role.feature?(feature_name)).to eq(false)
  end
end
