class SharePost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  SHARE_POST_PARAMS = [:post_id, :content, :status]

  has_one :activity, as: :trackable, dependent: :destroy

  enum status: [:public_post, :private_post]
end
