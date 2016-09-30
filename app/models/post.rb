class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader

  POST_PARAMS = [:image, :content, :status, job_post_attributes: [:name,
    :location, :job_type_id]]

  belongs_to :user

  has_one :job_post, dependent: :destroy, inverse_of: :post

  has_one :activity, as: :trackable, dependent: :destroy
  has_many :share_posts, dependent: :destroy

  validates :content, presence: true, if: lambda {image.blank? || job_post.present?}

  enum status: [:public_post, :private_post]

  accepts_nested_attributes_for :job_post

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :id, :name, :location, to: :job_post, prefix: true, allow_nil: true
end
