class ApplyJob < ApplicationRecord
  belongs_to :user
  belongs_to :job_post

  PARAMS_APPLY_JOB = [:job_post_id]

  validates_uniqueness_of :user_id, scope: :job_post_id

  delegate :id, to: :job_post, prefix: true, allow_nil: true

  scope :select_by_job, ->job_post_id{where job_post_id: job_post_id}
end
