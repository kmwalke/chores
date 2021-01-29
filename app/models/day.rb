class Day < ApplicationRecord
  has_many :schedules

  validates :name, presence: true, uniqueness: true

  MONDAY    = 'monday'.freeze
  TUESDAY   = 'tuesday'.freeze
  WEDNESDAY = 'wednesday'.freeze
  THURSDAY  = 'thursday'.freeze
  FRIDAY    = 'friday'.freeze
  SATURDAY  = 'saturday'.freeze
  SUNDAY    = 'sunday'.freeze

  NAMES = [MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY].freeze
end
