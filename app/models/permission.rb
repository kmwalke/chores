class Permission < ApplicationRecord
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :actions
  belongs_to :feature

  validates :feature, presence: true

  def create?
    actions.where(name: Action::CREATE).any?
  end

  def destroy?
    actions.where(name: Action::DESTROY).any?
  end

  def edit?
    actions.where(name: Action::EDIT).any?
  end

  def index?
    actions.where(name: Action::INDEX).any?
  end

  def new?
    actions.where(name: Action::NEW).any?
  end

  def show?
    actions.where(name: Action::SHOW).any?
  end

  def update?
    actions.where(name: Action::UPDATE).any?
  end

  def to_s
    "#{feature.name}: " \
      "#{'C' if create?} " \
      "#{'D' if destroy?} " \
      "#{'E' if edit?} " \
      "#{'I' if index?} " \
      "#{'N' if new?} " \
      "#{'S' if show?} " +
      ('U' if update?).to_s
  end
end
