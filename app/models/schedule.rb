class Schedule < ApplicationRecord
  validate :occurrences_or_due_date?

  belongs_to :model, polymorphic: true

  private

  def occurrences_or_due_date?
    return if occurrences.present? || due_date.present?

    errors.add(:occurences_or_due_date, 'Either occurences or due date is required')
  end
end
