FactoryGirl.define do
  factory :spreadsheet do
    filename 'my_favourite_spreadsheet.xlsx'
    association :owner, factory: :user
  end
end