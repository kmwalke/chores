class Task < ApplicationRecord
  XP_FACTOR = 10

  belongs_to :user
  has_many :task_instances

  validates :name, presence: true
  validates :frequency, presence: true, numericality: { greater_than: 0, less_than: 32 }
  validates :size, presence: true, numericality: { greater_than: 0, less_than: 6 }
  validates :user_id, presence: true

  before_save :set_xp

  def set_xp
    self.xp = frequency * size * XP_FACTOR
  end

  def bonus_xp
    (xp * (user.xp_multiplier - 1)).to_i
  end

  private

  def xp=(value)
    super(value)
  end
end
