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
  end

  def uncomplete!
    update(completed_at: nil)
  end

  def completed?
    !completed_at.nil?
  end
end
