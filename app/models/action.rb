class Action < ApplicationRecord
  has_and_belongs_to_many :permissions

  CREATE  = 'create'.freeze
  READ    = 'read'.freeze
  UPDATE  = 'update'.freeze
  DESTROY = 'delete'.freeze

  NAMES = [CREATE, READ, UPDATE, DESTROY].freeze
end
