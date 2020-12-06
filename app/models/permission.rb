class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
