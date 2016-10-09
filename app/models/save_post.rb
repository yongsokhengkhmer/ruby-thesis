class SavePost < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  SAVE_POST_PARAMS = [:activity_id]

  validates :user_id, presence: true
  validates :activity_id, presence: true
  validates_uniqueness_of :user_id, scope: :activity_id

  scope :load_save_posts, ->activity_id{where activity_id: activity_id}
end
