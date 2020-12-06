class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  DELETE = 'delete'.freeze
  CREATE = 'create'.freeze
  UPDATE = 'update'.freeze
  READ   = 'read'.freeze

  ACTIONS = [DELETE, CREATE, UPDATE, READ].freeze
end
