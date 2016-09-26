class JobType < ApplicationRecord
  has_many :job_posts, dependent: :nullify
end
