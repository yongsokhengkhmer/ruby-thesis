class SharePost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  SHARE_POST_PARAMS = [:post_id, :content, :status]

  has_one :activity, as: :trackable, dependent: :destroy

  enum status: [:public_post, :private_post]

  delegate :user_id, to: :post, prefix: true, allow_nil: true

  after_create :push_notification

  private
  def push_notification
    SharePostJob.perform_now(self) if public_post?
  end
end
