FactoryGirl.define do
  factory :event_invite do
    association :event
    association :user
  end
end
