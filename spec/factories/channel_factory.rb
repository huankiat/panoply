FactoryGirl.define do
  factory :channel do
    description 'recurring sales'
    value '1234'
    association :owner, factory: :user
  end
end