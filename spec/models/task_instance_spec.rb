require 'rails_helper'

RSpec.describe TaskInstance, type: :model do
  let(:instance) { create(:task_instance) }

  it 'requires a task' do
    expect(described_class.create(task_id: nil).errors).to have_key(:task_id)
  end

  it 'defaults to not completed' do
    expect(instance.completed?).to be(false)
    expect(instance.completed_at).to be_nil
  end

  it 'is completed' do
    instance.complete!
    expect(instance.reload.completed?).to be(true)
    expect(instance.completed_at.class).to eq(ActiveSupport::TimeWithZone)
  end

  it 'is uncompleted' do
    instance.uncomplete!
    expect(instance.reload.completed?).to be(false)
    expect(instance.completed_at).to be_nil
  end

  it 'toggles completion' do
    instance.toggle_complete!
    expect(instance.reload.completed?).to be(true)
    expect(instance.completed_at.class).to eq(ActiveSupport::TimeWithZone)

    instance.toggle_complete!
    expect(instance.reload.completed?).to be(false)
    expect(instance.completed_at).to be_nil
  end

  it 'adds xp when completed' do
    old_xp = instance.task.user.xp
    instance.complete!
    expect(instance.reload.task.user.xp).to be > old_xp
  end

  it 'increments multiplier when completed' do
    old_mult = instance.task.user.xp_multiplier
    instance.complete!
    expect(instance.reload.task.user.xp_multiplier).to be > old_mult
  end

  it 'removes xp when uncompleted' do
    create(:task_instance, task: instance.task).complete!
    instance.complete!
    old_xp = instance.reload.task.user.xp
    instance.uncomplete!
    expect(instance.reload.task.user.xp).to be < old_xp
  end

  it 'decrements multiplier when uncompleted' do
    instance.complete!
    old_mult = instance.reload.task.user.xp_multiplier
    instance.uncomplete!
    expect(instance.reload.task.user.xp_multiplier).to be < old_mult
  end
end
