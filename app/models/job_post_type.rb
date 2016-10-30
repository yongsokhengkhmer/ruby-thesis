class JobPostType < ApplicationRecord
  belongs_to :job_post
  belongs_to :job_type

  validates_uniqueness_of :job_type_id, scope: :job_post_id
end
