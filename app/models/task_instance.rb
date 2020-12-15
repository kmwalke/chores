class TaskInstance < ApplicationRecord
  belongs_to :task

  validates :task_id, presence: true

  def complete!
    update(completed_at: DateTime.new)
  end

  def completed?
    !completed_at.nil?
  end
end
