# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cloud_account do
    name "MyString"
    charge_index "MyString"
    customer_type "MyString"
    organization "MyString"
  end
end
