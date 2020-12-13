class TaskInstance < ApplicationRecord
  belongs_to :task

  validates :task_id, presence: true

  def complete!
    update(completed?: true, completed_at: DateTime.new)
  end
end
