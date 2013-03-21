FactoryGirl.define do
  factory :spreadsheet do
    sequence(:uuid) { |n| "unique_identifier_#{n}" }
    filename 'my_favourite_spreadsheet.xlsx'
  end
end