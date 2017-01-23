FactoryGirl.define do
  factory :event do
    date DateTime.now + 2.days
    place 'Kiev'
    purpose 'Global warming'
    description 'Some description'

    trait :with_user do
      association :user
    end
  end
end
