FactoryGirl.define do
  factory :channel do
    association :publisher, factory: :spreadsheet
    description 'recurring sales'
    value 1234
    metadata 'some data'
  end
end