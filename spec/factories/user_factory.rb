FactoryGirl.define do
  factory :user do
    name 'Ivan'
    email { generate(:email) }
    uid 'some_uid'
  end
  sequence :email do |n|
    "user_#{n}@mail.com"
  end
end
