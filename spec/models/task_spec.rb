require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { FactoryBot.create(:task) }
  it 'should require a name' do
    expect(Task.create(name: '').errors).to have_key(:name)
  end

  it 'should require a user' do
    expect(Task.create(user_id: nil).errors).to have_key(:user_id)
  end

  it 'should require a frequency' do
    expect(Task.create(frequency: '').errors).to have_key(:frequency)
  end

  it 'should require a positive frequency' do
    expect(Task.create(frequency: 0).errors).to have_key(:frequency)
  end

  it 'should require a size' do
    expect(Task.create(size: '').errors).to have_key(:size)
  end

  it 'should require a positive size' do
    expect(Task.create(size: 0).errors).to have_key(:size)
  end

  it 'should generate an xp value' do
    expect(FactoryBot.create(:task).xp > 0).to eq(true)
  end

  it 'should update the xp value' do
    old_xp = task.xp
    task.update_attribute(:size, task.size + 1)
    expect(task.xp > old_xp).to eq(true)
  end

  it 'should not allow xp to be set' do
    expect(Task.new.respond_to?('xp=')).to eq(false)
  end
end
