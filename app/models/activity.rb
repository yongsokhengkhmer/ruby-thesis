class Activity < ApplicationRecord
  belongs_to :trackable, polymorphic: true
  belongs_to :user

  delegate :avatar, :name, to: :user, prefix: true, allow_nil: true
end
