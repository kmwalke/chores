module SoftDeletable
  extend ActiveSupport::Concern

  included do
    default_scope { where(deleted_at: nil) }
    scope :only_deleted, -> { unscope(where: :deleted_at).where.not(deleted_at: nil) }
    scope :include_deleted, -> { unscope(where: :deleted_at) }
  end

  def soft_delete
    update(deleted_at: DateTime.now)
  end

  def deleted?
    deleted_at != nil
  end

  def soft_undelete
    update(deleted_at: nil)
  end
end
