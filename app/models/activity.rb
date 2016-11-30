class Activity < ApplicationRecord
  belongs_to :trackable, polymorphic: true
  belongs_to :user

  has_many :save_posts, dependent: :destroy
  has_many :like_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  delegate :avatar, :name, to: :user, prefix: true, allow_nil: true
  delegate :content, :user_id, to: :trackable, prefix: true, allow_nil: true

  enum status: [:public_post, :private_post]

  scope :load_activities, -> do
    preload(:trackable, :user, :comments).order created_at: :desc
  end

  scope :load_public_activities, -> do
    public_post.preload(:trackable, :user, :comments).order created_at: :desc
  end

  scope :load_public_activities_of, -> user_ids do
    public_post.preload(:trackable, :user, :comments).where(user_id: user_ids)
      .order created_at: :desc
  end

  def get_post
    trackable_type == "Post" ? trackable : trackable.post
  end
end
