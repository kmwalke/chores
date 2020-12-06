class Action < ApplicationRecord
  DELETE = 'delete'.freeze
  CREATE = 'create'.freeze
  UPDATE = 'update'.freeze
  READ   = 'read'.freeze

  ALL = [DELETE, CREATE, UPDATE, READ].freeze
end
