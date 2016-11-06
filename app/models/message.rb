class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  scope :load_messages, ->{preload :user}
end
