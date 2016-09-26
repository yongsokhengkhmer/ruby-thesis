class UserProfile < ApplicationRecord
  belongs_to :user

  validates :gender, presence: true
  validates :birth_date, presence: true

  enum gender: [:male, :female]
end
