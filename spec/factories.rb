require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    email                 "test@example.com"
    password              "password"
    password_confirmation "password"
  end
end

# to easily generate email sequences
FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end