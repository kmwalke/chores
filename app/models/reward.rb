class Reward < ApplicationRecord
  validates :name, presence: true
  validates :user_id, presence: true

  belongs_to :user

  before_save :abbreviate

  def abbreviate
    update(abbreviation: name[0..1]) if abbreviation != name[0..1]
  end
end
