class Feed < ActiveRecord::Base
  belongs_to :user
  belongs_to :targetable, polymorphic: true

  validates :user_id, :targetable_id, :targetable_type, :message, presence: true
  validates :message, length: { maximum: 250 }
end
