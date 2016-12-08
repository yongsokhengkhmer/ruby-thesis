class Country < ApplicationRecord
  COUNTRY_PARAMS = [:name]

  has_many :users, dependent: :destroy
  has_many :job_posts, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
