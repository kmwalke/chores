class User < ApplicationRecord
  has_secure_password

  belongs_to :role
  has_many :tasks
  has_many :task_instances, through: :tasks

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :xp_multiplier, not_less_than_one: true

  XP_PER_LEVEL = 100

  def add_xp(amount)
    self.xp += (amount * xp_multiplier)
    level_up
    save
  end

  def level_up
    self.level = (xp / XP_PER_LEVEL).floor + 1
  end

  def progress_to_level
    xp % XP_PER_LEVEL.to_f / 100
  end

  def task_list(date = Date.today)
    raise ArgumentError, 'Date cannot be in the future' if date > Date.today

    task_instances.select { |i| i.created_on == date }
  end

  def instantiate_tasks
    return unless task_list.empty?

    # TODO: Use algorithm to select, not random
    tasks.order(Arel.sql('RANDOM()')).first(10).each do |task|
      TaskInstance.create(task: task)
    end
  end
end
