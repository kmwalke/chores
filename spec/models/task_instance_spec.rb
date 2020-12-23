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
end
