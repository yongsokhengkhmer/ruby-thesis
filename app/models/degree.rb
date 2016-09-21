class Degree < ApplicationRecord
  has_many :educations, dependent: :destroy
end
