class Relationship < ApplicationRecord
  RELATIONSHIP_PARAMS = [:followed_id]

  belongs_to :follower, class_name: User, foreign_key: :follower_id
  belongs_to :followed, class_name: User, foreign_key: :followed_id

  validates_uniqueness_of :follower_id, scope: :followed_id

  after_create :push_notification

  private
  def push_notification
    RelationshipJob.perform_now self
  end
end
