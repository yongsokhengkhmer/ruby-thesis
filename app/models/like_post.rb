class LikePost < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  LIKE_POST_PARAMS = [:activity_id]

  validates :user_id, presence: true
  validates :activity_id, presence: true
  validates_uniqueness_of :user_id, scope: [:activity_id]

  delegate :activity, :id, to: :user, prefix: true, allow_nil: true

  scope :by_activity, ->activity_id{where activity_id: activity_id}

  after_create :push_notification

  private
  def push_notification
    LikePostJob.perform_now(self) unless activity.trackable_user_id == self.user_id
  end
end
