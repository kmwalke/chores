class Task < ApplicationRecord
  XP_FACTOR = 10

  belongs_to :user
  has_many :task_instances

  validates :name, presence: true
  validates :frequency, presence: true, numericality: { greater_than: 0 }
  validates :size, presence: true, numericality: { greater_than: 0 }
  validates :user_id, presence: true

  before_save :set_xp

  def set_xp
    self.xp = frequency * size * XP_FACTOR
  end

  private

  def xp=(value)
    super(value)
  end
end
