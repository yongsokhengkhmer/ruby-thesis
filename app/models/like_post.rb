class LikePost < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  LIKE_POST_PARAMS = [:activity_id]

  validates :user_id, presence: true
  validates :activity_id, presence: true
  validates_uniqueness_of :user_id, scope: [:activity_id]

  delegate :activity, :id, to: :user, prefix: true, allow_nil: true

  scope :by_activity, ->activity_id{where activity_id: activity_id}
end
