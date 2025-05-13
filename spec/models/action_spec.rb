require 'rails_helper'

RSpec.describe Action do
  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  it 'requires a unique name' do
    expect(described_class.create(name: create(:action).name).errors).to have_key(:name)
  end
end
