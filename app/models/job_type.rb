class JobType < ApplicationRecord
  JOB_TYPE_PARAMS = [:name]

  has_many :user_job_types, dependent: :destroy
  has_many :job_post_types, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
