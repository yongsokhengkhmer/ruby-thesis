class JobType < ApplicationRecord
  has_many :user_job_types, dependent: :destroy
end
