class EventInvite < ActiveRecord::Base
  has_many :feeds, as: :targetable
  belongs_to :event
  belongs_to :user

  after_create :create_feed

  validates :event_id, :user_id, presence: true
  validates :event_id, uniqueness: {scope: :user_id}
  validate :is_owner?

  def is_owner?
    if event && user
      errors.add(:user_id, :invalid, message: 'Can not invite owner') if event.user.id == user.id
    end
  end

  def create_feed
    feeds.create(message: "You got invitation for event ##{event_id}", user_id: user_id)
  end
end
