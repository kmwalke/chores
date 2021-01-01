class Role < ApplicationRecord
  has_and_belongs_to_many :permissions
  has_many :user

  validates :name, presence: true, uniqueness: true

  def feature?(name)
    feature = Feature.find_by(name: name.downcase)
    permissions.select { |p| p.feature_id == feature.id }.any? unless feature.nil?
  end
end
