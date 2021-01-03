class Task < ApplicationRecord
  XP_FACTOR = 10

  belongs_to :user
  has_many :task_instances,dependent: :destroy

  validates :name, presence: true
  validates :frequency, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 31 }
  validates :size, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
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
