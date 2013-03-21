FactoryGirl.define do
  factory :spreadsheet do
    uuid { Time.now }
    filename 'my_favourite_spreadsheet.xlsx'
  end
end