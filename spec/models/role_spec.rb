require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'should require a name' do
    expect(Role.create(name: '').errors).to have_key(:name)
  end

  it 'should require a unique name' do
    Role.create(name: 'name', description: 'desc')
    expect(Role.create(name: 'name', description: 'desc').errors).to have_key(:name)
  end

  it 'should have permissions' do
    p = Permission.create(name: 'name', description: 'desc')
    r = Role.create(name: 'name', description: 'desc')
    r.permissions << p

    expect(r.reload.permissions.first).to eq(p)
  end
end
