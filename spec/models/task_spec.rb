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

  it 'should require frequency of 31 or less' do
    expect(Task.create(frequency: 32).errors).to have_key(:frequency)
  end

  it 'should require a size' do
    expect(Task.create(size: '').errors).to have_key(:size)
  end

  it 'should require a positive size' do
    expect(Task.create(size: 0).errors).to have_key(:size)
  end

  it 'should require a size of 5 or less' do
    expect(Task.create(size: 6).errors).to have_key(:size)
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

  it 'should calculate bonus xp at 0' do
    expect(task.bonus_xp).to eq(0)
  end

  it 'should calculate bonus xp' do
    task.user.increment_xp_multiplier!
    expect(task.reload.bonus_xp).to be > 0
  end

  describe 'data privacy' do
    it 'cascade deletes task instances' do
      instance_id = FactoryBot.create(:task_instance, task: task).id
      task.destroy
      expect(TaskInstance.find_by(id: instance_id)).to be_nil
    end
  end
end
