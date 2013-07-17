# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    number_and_street "MyString"
    city "MyString"
    state "MyString"
    zip_code "MyString"
  end
end
