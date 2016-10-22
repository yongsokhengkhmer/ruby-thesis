class Feedback < ApplicationRecord
  FEEDBACK_PARAMS = [:subject, :content]

  belongs_to :user
  has_one :notification, as: :trackable, dependent: :destroy

  validates :subject, presence: true
  validates :content, presence: true

  delegate :name, to: :user, prefix: true, allow_nil: true

  after_create :push_notification

  private
  def push_notification
    FeedbackJob.perform_now self
  end
end
