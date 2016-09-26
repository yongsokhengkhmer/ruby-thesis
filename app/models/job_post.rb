class JobPost < ApplicationRecord
  belongs_to :job_type
  belongs_to :post

  delegate :name, to: :job_type, prefix: true, allow_nil: true
end
