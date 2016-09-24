class SharePost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :activities, as: :trackable, dependent: :destroy

  enum status: [:public_post, :private_post]
end
