class Country < ApplicationRecord
  has_many :users
  has_many :job_posts
end
