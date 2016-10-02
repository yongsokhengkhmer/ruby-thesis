class ApplyJob < ApplicationRecord
  belongs_to :user
  belongs_to :job_post

  has_one :notification, as: :trackable, dependent: :destroy

  PARAMS_APPLY_JOB = [:job_post_id]

  validates_uniqueness_of :user_id, scope: :job_post_id

  delegate :id, to: :job_post, prefix: true, allow_nil: true
  delegate :id, to: :user, prefix: true, allow_nil: true

  scope :select_by_job, ->job_post_id{where job_post_id: job_post_id}

  after_create :push_notification

  private
  def push_notification
   JobApplyJob.perform_now self
  end
end
