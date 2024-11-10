class User < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :rsvps
  has_many :events, through: :rsvps

  enum user_type: {"event_manager": 0, "attendee": 1}
  # enum user_type: { admin: 0, moderator: 1, regular: 2 }
end
