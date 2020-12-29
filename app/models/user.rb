class User < ApplicationRecord
  include DateInZone

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
  validates :time_zone, presence: true, time_zone: true
  validates :xp_multiplier, not_less_than_one: true

  TASKS_PER_DAY     = 5
  XP_PER_LEVEL      = 1000
  XP_MULT_INCREMENT = 0.1
  MAX_XP_MULT       = 2

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

  def increment_xp_multiplier!
    return if xp_multiplier >= MAX_XP_MULT

    self.xp_multiplier += XP_MULT_INCREMENT
    save
  end

  def decrement_xp_multiplier!
    return if xp_multiplier == 1

    self.xp_multiplier -= XP_MULT_INCREMENT
    save
  end

  def reset_xp_multiplier!
    self.xp_multiplier = 1
    save
  end

  def xp_this_level
    xp % XP_PER_LEVEL
  end

  def progress_to_level
    xp_this_level.to_f / XP_PER_LEVEL
  end

  def task_list(date = today_in_zone(time_zone))
    raise ArgumentError, 'Date cannot be in the future' if date > today_in_zone(time_zone)

    task_instances.select { |i| i.created_on == date }
  end

  def build_task_list
    return if task_list?

    reset_xp_multiplier! unless tasks_completed?(yesterday_in_zone(time_zone))
    # TODO: Use algorithm to select, not random
    tasks.order(Arel.sql('RANDOM()')).first(TASKS_PER_DAY).each do |task|
      TaskInstance.create(task: task)
    end
  end

  def task_list?(date = today_in_zone(time_zone))
    tasks.empty? || task_list(date).any?
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

  def tasks_completed?(date = today_in_zone(time_zone))
    task_list(date).select do |instance|
      instance.completed_at.nil?
    end.empty?
  end

  def xp=(value)
    super(value)
  end

  def xp_multiplier=(value)
    super(value)
  end
end
