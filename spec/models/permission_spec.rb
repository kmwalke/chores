require 'rails_helper'

RSpec.describe Permission, type: :model do
  it 'should require a name' do
    expect(Permission.create(name: '').errors).to have_key(:name)
  end

  it 'should require a unique name' do
    FactoryBot.create(:permission, name: 'name')
    expect(Permission.create(name: 'name').errors).to have_key(:name)
  end

  it 'should require a description' do
    expect(Permission.create(description: '').errors).to have_key(:description)
  end

  it 'should have permissions' do
    p = FactoryBot.create(:permission)
    r = FactoryBot.create(:role)
    p.roles << r

    expect(p.reload.roles.first).to eq(r)
  end
end
