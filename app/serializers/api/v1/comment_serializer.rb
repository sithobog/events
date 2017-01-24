class Api::V1::CommentSerializer < Api::V1::BaseSerializer
  attributes :id, :content, :author, :event_id, :created_at, :updated_at
end
