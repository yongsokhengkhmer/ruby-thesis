class Education < ApplicationRecord
  belongs_to :degree
  belongs_to :user

  scope :order_date, ->{order end_date: :desc}

  validates :school, presence: true
  validates :field_of_study, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  delegate :name, to: :degree, prefix: true, allow_nil: true
end
