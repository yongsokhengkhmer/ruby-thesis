class MarkInterest < ApplicationRecord
  belongs_to :marker, class_name: User, foreign_key: :marker_id
  belongs_to :marked, class_name: User, foreign_key: :marked_id

  MARK_INTERTEST_PARAMS = [:marked_id]

  delegate :id, to: :marked, prefix: true, allow_nil: true

  validates_uniqueness_of :marker_id, scope: :marked_id

  scope :by_marked_id, ->marked_id{where marked_id: marked_id}
end
