require 'rails_helper'

RSpec.describe TaskInstance do
  let(:instance) { create(:task_instance) }

  it 'requires a task' do
    expect(described_class.create(task_id: nil).errors).to have_key(:task_id)
  end

  it 'defaults to not completed' do
    expect(instance.completed?).to be(false)
  end

  it 'defaults completed_at to nil' do
    expect(instance.completed_at).to be_nil
  end

  describe 'completed' do
    before do
      instance.complete!
    end

    it 'is completed' do
      expect(instance.reload.completed?).to be(true)
    end

    it 'sets completed_at' do
      expect(instance.completed_at.class).to eq(ActiveSupport::TimeWithZone)
    end
  end

  describe 'uncompleted' do
    before do
      instance.uncomplete!
    end

    it 'is uncompleted' do
      expect(instance.reload.completed?).to be(false)
    end

    it 'sets completed_at to nil' do
      expect(instance.completed_at).to be_nil
    end
  end

  describe 'toggling completion' do
    before do
      instance.toggle_complete!
    end

    it 'toggles completion on' do
      expect(instance.reload.completed?).to be(true)
    end

    it 'sets completed_at' do
      expect(instance.completed_at.class).to eq(ActiveSupport::TimeWithZone)
    end

    describe 'toggling again' do
      before do
        instance.toggle_complete!
      end

      it 'toggles completion off' do
        expect(instance.reload.completed?).to be(false)
      end

      it 'sets completed_at to nil' do
        expect(instance.completed_at).to be_nil
      end
    end
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
