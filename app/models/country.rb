class Country < ApplicationRecord
  COUNTRY_PARAMS = [:name]

  has_many :users
  has_many :job_posts

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
