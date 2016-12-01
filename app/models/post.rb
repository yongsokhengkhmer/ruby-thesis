class Post < ApplicationRecord
  mount_uploader :image, PostImageUploader

  POST_PARAMS = [:image, :content, job_post_attributes: [:id, :name,
    :country_id, :negotiable, :min_salary, :max_salary, job_type_ids: []],
    activity_attributes: [:id, :user_id, :status]]

  belongs_to :user

  has_one :job_post, dependent: :destroy, inverse_of: :post
  has_one :activity, as: :trackable, dependent: :destroy

  has_many :share_posts, dependent: :destroy
  has_many :notifications, as: :trackable, dependent: :destroy

  validates :content, presence: true, if: lambda {image.blank? || job_post.present?}

  accepts_nested_attributes_for :job_post
  accepts_nested_attributes_for :activity

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :id, :name, :location, to: :job_post, prefix: true, allow_nil: true

  scope :load_posts, -> do
    includes(:job_post, :activity).where(job_posts: {post_id: nil}).order created_at: :desc
  end

  after_create :push_notification

  private
  def push_notification
   PostNotificationJob.perform_now(self) if activity.public_post?
  end
end
