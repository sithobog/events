class Comment < ActiveRecord::Base
  validates :author, :content, presence: true
  validates :author, length: { maximum: 150 }
  validates :content, length: { maximum: 500 }
  validates :event, presence: true
  belongs_to :event
end
