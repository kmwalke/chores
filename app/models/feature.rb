class Feature < ApplicationRecord
  has_many :permissions

  validates :name, presence: true, uniqueness: true
end
