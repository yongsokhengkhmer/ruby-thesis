class ApplyJob < ApplicationRecord
  belongs_to :user
  belongs_to :job_post

  PARAMS_APPLY_JOB = [:job_post_id]

  validates_uniqueness_of :user_id, scope: :job_post_id

  delegate :id, to: :job_post, prefix: true, allow_nil: true
  delegate :id, :avatar_url, :name, to: :user, prefix: true, allow_nil: true

  scope :select_by_job, ->job_post_id{where job_post_id: job_post_id}
  scope :order_by_user, ->{joins(:user).includes(:user).order "users.name"}
  scope :load_apply_jobs, ->do
    preload(job_post: [:job_type, post: :activity]).order created_at: :desc
  end

  after_create :push_notification

  private
  def push_notification
   JobApplyJob.perform_now self
  end
end
