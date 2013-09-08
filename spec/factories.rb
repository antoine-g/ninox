require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    email                 "test@example.com"
    password              "password"
    password_confirmation "password"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :course do
    name "Course name"
    code "AA01"
  end

  sequence :code do |n|
    "BB0#{n}" if n <10
    "BB#{n}" if 9 < n 100
  end
end