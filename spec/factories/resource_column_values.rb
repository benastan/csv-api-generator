# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :resource_column_value do
    resource_column_id 1
    value "MyString"
  end
end
