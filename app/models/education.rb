class Education < ApplicationRecord
  belongs_to :degree
  belongs_to :user

  validates :school, presence: true
  validates :field_of_study, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
