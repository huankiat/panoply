FactoryGirl.define do
  factory :broadcast do
    description 'recurring sales broadcast'
    association :owner, factory: :user
  end
end