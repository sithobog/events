FactoryGirl.define do
  factory :feed do
    association :user
    message 'Useful message'
  end
end
