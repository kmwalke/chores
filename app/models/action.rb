class Action < ApplicationRecord
  has_and_belongs_to_many :permissions

  validates :name, presence: true, uniqueness: true

  CREATE  = 'create'.freeze
  DELETE  = 'delete'.freeze
  DESTROY = 'destroy'.freeze
  EDIT    = 'edit'.freeze
  INDEX   = 'index'.freeze
  NEW     = 'new'.freeze
  SHOW    = 'show'.freeze
  UPDATE  = 'update'.freeze

  NAMES = [CREATE, DELETE, DESTROY, EDIT, INDEX, NEW, SHOW, UPDATE].freeze
end
