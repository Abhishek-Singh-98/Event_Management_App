class Event < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :rsvps, dependent: :destroy
  has_many :users, through: :rsvps

end
