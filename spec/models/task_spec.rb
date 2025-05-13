require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { create(:task) }

  it 'requires a name' do
    expect(described_class.create(name: '').errors).to have_key(:name)
  end

  it 'requires a user' do
    expect(described_class.create(user_id: nil).errors).to have_key(:user_id)
  end

  it 'requires a frequency' do
    expect(described_class.create(frequency: '').errors).to have_key(:frequency)
  end

  it 'requires a positive frequency' do
    expect(described_class.create(frequency: 0).errors).to have_key(:frequency)
  end

  it 'requires frequency of 31 or less' do
    expect(described_class.create(frequency: 32).errors).to have_key(:frequency)
  end

  it 'requires a size' do
    expect(described_class.create(size: '').errors).to have_key(:size)
  end

  it 'requires a positive size' do
    expect(described_class.create(size: 0).errors).to have_key(:size)
  end

  it 'requires a size of 5 or less' do
    expect(described_class.create(size: 6).errors).to have_key(:size)
  end

  it 'generates an xp value' do
    expect(create(:task).xp > 0).to be(true)
  end

  it 'updates the xp value' do
    old_xp = task.xp
    task.update_attribute(:size, task.size + 1)
    expect(task.xp > old_xp).to be(true)
  end

  it 'does not allow xp to be set' do
    expect(described_class.new.respond_to?('xp=')).to be(false)
  end

  it 'calculates bonus xp at 0' do
    expect(task.bonus_xp).to eq(0)
  end

  it 'calculates bonus xp' do
    task.user.increment_xp_multiplier!
    expect(task.reload.bonus_xp).to be > 0
  end

  describe 'data privacy' do
    it 'cascade deletes task instances' do
      instance_id = create(:task_instance, task: task).id
      task.destroy
      expect(TaskInstance.find_by(id: instance_id)).to be_nil
    end
  end
end
