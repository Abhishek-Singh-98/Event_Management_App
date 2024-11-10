class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: {"Confirmed": 0, "Canceled": 1, "Add To Bucket": 2}

  after_save :update_event_max_capacity

  private

  def update_event_max_capacity
    event = self.event
    event_capacity_left = event.max_capacity
    if self.saved_change_to_status?
      case self.status
      when "Confirmed"
        event.update_column(:max_capacity, event_capacity_left - 1)
      when "Canceled"
        event.update_column(:max_capacity, event_capacity_left + 1) if self.status_before_last_save != 'Add To Bucket'
      end
    end
  end
end
