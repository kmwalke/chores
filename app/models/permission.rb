class Permission < ApplicationRecord
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :actions
  belongs_to :feature

  validates :feature, presence: true

  def create?
    actions.where(name: Action::CREATE).any?
  end

  def read?
    actions.where(name: Action::READ).any?
  end

  def update?
    actions.where(name: Action::UPDATE).any?
  end

  def destroy?
    actions.where(name: Action::DESTROY).any?
  end

  def to_s
    "#{feature.name}: #{'C' if create?} #{'R' if read?} #{'U' if update?} #{'D' if destroy?}"
  end
end
