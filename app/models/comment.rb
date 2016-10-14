class Comment < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  COMMENT_PARAMS = [:content, :activity_id]

  validates :content, presence: true
  validates :activity_id, presence: true
  validates :user_id, presence: true

  delegate :name, to: :user, prefix: true, allow_nil: true
end
