class User < ApplicationRecord
  has_secure_password

  belongs_to :role
  belongs_to :next_reward, class_name: 'Reward', optional: true
  has_and_belongs_to_many :earned_rewards,
                          class_name: 'Reward',
                          join_table: 'rewards_users',
                          association_foreign_key: 'reward_id'
  has_many :rewards
  has_many :tasks
  has_many :task_instances, through: :tasks

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :xp_multiplier, not_less_than_one: true

  TASKS_PER_DAY = 5
  XP_PER_LEVEL  = 1000

  def avatar
    name[0..1].downcase.capitalize
  end

  def add_xp(amount)
    self.xp += (amount * xp_multiplier)
    level_up
    save
  end

  def remove_xp(amount)
    return if (amount * xp_multiplier) > xp_this_level

    add_xp(amount * -1)
  end

  def xp_this_level
    xp % XP_PER_LEVEL
  end

  def progress_to_level
    xp_this_level.to_f / XP_PER_LEVEL
  end

  def task_list(date = Date.today)
    raise ArgumentError, 'Date cannot be in the future' if date > Date.today

    task_instances.select { |i| i.created_on == date }
  end

  def instantiate_tasks
    return unless task_list.empty?

    # TODO: Use algorithm to select, not random
    tasks.order(Arel.sql('RANDOM()')).first(TASKS_PER_DAY).each do |task|
      TaskInstance.create(task: task)
    end
  end

  private

  def level_up
    return unless level_up?

    self.level = new_level
    earn_reward
    set_next_reward
  end

  def level_up?
    level < new_level
  end

  def new_level
    (xp / XP_PER_LEVEL).floor + 1
  end

  def earn_reward
    earned_rewards << next_reward if next_reward
  end

  def set_next_reward
    # TODO: Use algorithm to select, not random
    self.next_reward = rewards.order(Arel.sql('RANDOM()')).first
  end

  def xp=(value)
    super(value)
  end
end
