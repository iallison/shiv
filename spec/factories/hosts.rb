# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :host do
    name "MyString"
    kernel "MyString"
    operating_system "MyString"
    os_release "MyString"
    ip "MyString"
  end
end
