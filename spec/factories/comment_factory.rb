FactoryGirl.define do
  factory :comment do
    author 'Ivan Kuprin'
    content 'Amazing event!'

    trait :with_event do
      association :event
    end
  end
end
