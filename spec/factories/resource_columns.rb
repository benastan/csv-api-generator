# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource_column do
    resource_id 1
    name "MyString"
    data_type 1
  end
end
