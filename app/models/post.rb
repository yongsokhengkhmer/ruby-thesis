class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader

  belongs_to :user

  has_one :job_post, dependent: :destroy

  has_many :activities, as: :trackable, dependent: :destroy
  has_many :share_posts, dependent: :destroy

  enum status: [:public_post, :private_post]

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :name, :location, to: :job_post, prefix: true, allow_nil: true
end
