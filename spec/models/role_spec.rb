require 'rails_helper'

RSpec.describe Role, type: :model do
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

    expect(r.reload.permissions.first).to eq(p)
  end
end
