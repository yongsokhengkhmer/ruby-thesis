class Activity < ApplicationRecord
  belongs_to :trackable, polymorphic: true
  belongs_to :user

  has_many :save_posts, dependent: :destroy
  has_many :like_posts

  delegate :avatar, :name, to: :user, prefix: true, allow_nil: true
  delegate :content, to: :trackable, prefix: true, allow_nil: true

  def get_post
    trackable_type == "Post" ? trackable : trackable.post
  end
end
