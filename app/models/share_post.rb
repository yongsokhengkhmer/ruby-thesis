class SharePost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :activity, as: :trackable, dependent: :destroy

  enum status: [:public_post, :private_post]
end
