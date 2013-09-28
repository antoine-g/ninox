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
    if n < 10
      "BB0" + n.to_s
    else
      "BB#{n}"
    end
  end

  factory :document do
    title "Document title"
    desc "Description of the document"
  end
end