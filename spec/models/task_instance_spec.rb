require 'rails_helper'

RSpec.describe TaskInstance, type: :model do
  let(:instance) { FactoryBot.create(:task_instance) }

  it 'should require a task' do
    expect(TaskInstance.create(task_id: nil).errors).to have_key(:task_id)
  end

  it 'should default to not completed' do
    expect(instance.completed?).to be(false)
    expect(instance.completed_at).to be_nil
  end

  it 'should be completed' do
    instance.complete!
    expect(instance.reload.completed?).to be(true)
    expect(instance.completed_at.class).to eq(ActiveSupport::TimeWithZone)
  end

  it 'should be uncompleted' do
    instance.uncomplete!
    expect(instance.reload.completed?).to be(false)
    expect(instance.completed_at).to be_nil
  end

  it 'should toggle completion' do
    instance.toggle_complete!
    expect(instance.reload.completed?).to be(true)
    expect(instance.completed_at.class).to eq(ActiveSupport::TimeWithZone)

    instance.toggle_complete!
    expect(instance.reload.completed?).to be(false)
    expect(instance.completed_at).to be_nil
  end

  it 'should add xp when completed' do
    old_xp = instance.task.user.xp
    instance.complete!
    expect(instance.reload.task.user.xp).to be > old_xp
  end

  it 'should increment multiplier when completed' do
    old_mult = instance.task.user.xp_multiplier
    instance.complete!
    expect(instance.reload.task.user.xp_multiplier).to be > old_mult
  end

  it 'should remove xp when uncompleted' do
    FactoryBot.create(:task_instance, task: instance.task).complete!
    instance.complete!
    old_xp = instance.reload.task.user.xp
    instance.uncomplete!
    expect(instance.reload.task.user.xp).to be < old_xp
  end

  it 'should decrement multiplier when uncompleted' do
    instance.complete!
    old_mult = instance.reload.task.user.xp_multiplier
    instance.uncomplete!
    expect(instance.reload.task.user.xp_multiplier).to be < old_mult
  end
end
