require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { create(:role_admin) }

  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  it 'requires a unique name' do
    expect(described_class.create(name: create(:role).name).errors).to have_key(:name)
  end

  it 'has permissions' do
    p = create(:permission)
    r = create(:role)
    r.permissions << p

    expect(r.reload.permissions.include?(p)).to be(true)
  end

  it 'has feature' do
    feature_name = role.permissions.first.feature.name
    expect(role.feature?(feature_name)).to be(true)
  end

  it 'does not have feature' do
    feature_name = create(:feature).name
    expect(role.feature?(feature_name)).to be(false)
  end
end
