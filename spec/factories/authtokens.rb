# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authtoken do
    provider "MyString"
    uid "MyString"
    token "MyString"
    email "MyString"
    name "MyString"
    url "MyString"
  end
end
