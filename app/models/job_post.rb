class JobPost < ApplicationRecord
  belongs_to :job_type
  belongs_to :post

  has_many :apply_jobs, dependent: :destroy

  delegate :name, to: :job_type, prefix: true, allow_nil: true
  delegate :user_id, to: :post, prefix: true, allow_nil: true
end
