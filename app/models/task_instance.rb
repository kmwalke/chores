class TaskInstance < ApplicationRecord
  belongs_to :task

  validates :task_id, presence: true

  def toggle_complete!
    if completed?
      uncomplete!
    else
      complete!
    end
  end

  def complete!
    update(completed_at: DateTime.new)
    task.user.add_xp(task.xp)
    task.user.increment_xp_multiplier!
  end

  def uncomplete!
    update(completed_at: nil)
    task.user.remove_xp(task.xp)
    task.user.decrement_xp_multiplier!
  end

  def completed?
    !completed_at.nil?
  end
end
