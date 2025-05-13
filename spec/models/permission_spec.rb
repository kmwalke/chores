require 'rails_helper'

RSpec.describe Permission, type: :model do
  it 'requires a feature' do
    expect(described_class.create(feature: nil).errors).to have_key(:feature)
  end

  it 'has actions' do
    p = create(:permission)
    a = create(:action)
    p.actions << a

    expect(p.reload.actions.include?(a)).to be(true)
  end

  it 'has roles' do
    p = create(:permission)
    r = create(:role)
    p.roles << r

    expect(p.reload.roles.include?(r)).to be(true)
  end
end
