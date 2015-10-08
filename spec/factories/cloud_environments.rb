# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cloud_environment, :class => 'CloudEnvironments' do
    name "MyString"
    host_network "MyString"
    host_gateway "MyString"
    host_vlan "MyString"
    host_gateway "MyString"
    container_network "MyString"
    container_vlan "MyString"
    container_gateway "MyString"
    overlay_network "MyString"
    overlay_vlan "MyString"
    overlay_gateway "MyString"
    storage_network "MyString"
    storage_vlan "MyString"
    storage_gateway "MyString"
    swift_network "MyString"
    swift_vlan "MyString"
    swift_gateway "MyString"
  end
end
