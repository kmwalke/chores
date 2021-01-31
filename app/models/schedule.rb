class Schedule < ApplicationRecord
  belongs_to :model, polymorphic: true
end
