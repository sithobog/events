class Comment < ActiveRecord::Base
  has_many :feeds, as: :targetable
  belongs_to :event
  
  after_create :create_feed

  validates :author, :content, presence: true
  validates :author, length: { maximum: 150 }
  validates :content, length: { maximum: 500 }
  validates :event, presence: true

  def create_feed
    feeds.create(message: 'New comment in your event discussion', user_id: event.user.id)
  end
end
