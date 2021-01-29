class Schedule < ApplicationRecord
  has_many :days
  belongs_to :model, polymorphic: true
end
