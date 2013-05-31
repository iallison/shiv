# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cloud_user do
    name "MyString"
    admin ""
    contact_id ""
    sla_accept_date "2013-05-31 12:43:41"
  end
end
