class Activity < ApplicationRecord
  belongs_to :trackable, polymorphic: true
  belongs_to :user

  has_many :save_posts, dependent: :destroy

  delegate :avatar, :name, to: :user, prefix: true, allow_nil: true
end
