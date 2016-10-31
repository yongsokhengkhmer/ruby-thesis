class UserJobType < ApplicationRecord
  belongs_to :user
  belongs_to :job_type

  validates_uniqueness_of :user_id, scope: :job_type_id
end
