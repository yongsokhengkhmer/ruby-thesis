class JobPost < ApplicationRecord
  belongs_to :job_type
  belongs_to :post

  has_many :apply_jobs, dependent: :destroy

  validates :name, presence: true
  validates :location, presence: true
  validates :job_type_id, presence: true

  delegate :name, to: :job_type, prefix: true, allow_nil: true
  delegate :user_id, :content, to: :post, prefix: true, allow_nil: true

  scope :by_user, ->user_id do
    joins(:post).where("posts.user_id = ?", user_id).preload(:job_type)
    .order created_at: :desc
  end
end
