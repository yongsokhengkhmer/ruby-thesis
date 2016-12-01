class SharePost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  SHARE_POST_PARAMS = [:post_id, :content, activity_attributes: [:id, :user_id, :status]]

  has_one :activity, as: :trackable, dependent: :destroy

  has_many :notifications, as: :trackable, dependent: :destroy

  delegate :user_id, to: :post, prefix: true, allow_nil: true

  accepts_nested_attributes_for :activity

  after_create :push_notification

  private
  def push_notification
    SharePostJob.perform_now(self) if activity.public_post?
  end
end
