class Api::V1::EventInviteSerializer < Api::V1::BaseSerializer
  attributes :id, :user_id, :event_id
end
