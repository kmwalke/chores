require 'rails_helper'

RSpec.describe Feature do
  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  it 'requires a unique name' do
    create(:feature, name: 'name')
    expect(described_class.create(name: 'name').errors).to have_key(:name)
  end

  it 'has permissions' do
    f = create(:feature)
    p = create(:permission)
    f.permissions << p

    expect(f.reload.permissions.first).to eq(p)
  end
end
