class Api::V1::EventSerializer < Api::V1::BaseSerializer
  attributes :id, :date, :place,  :purpose, :description, :user_id, :created_at, :updated_at
  has_many :comments
end
