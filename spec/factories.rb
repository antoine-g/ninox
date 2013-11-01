require 'factory_girl_rails'

FactoryGirl.define do

  factory :user do
    email                 "test@example.com"
    password              "password"
    password_confirmation "password"
  end

  factory :course do
    name "Course name"
    code "AA01"
  end

  factory :document do
    title   "Document title"
    docfile { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'testdoc.txt'), 'text/txt')}
    user    FactoryGirl.create(:user)
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :code do |n|
    if n%100 < 10
      "BB0" + (n%100).to_s
    else
      "BB#{n%100}"
    end
  end

  # factory :document do
  #   title "Document title"
  #   desc "Description of the document"
  #   docfile {fixture_file_upload('/files/testdoc.txt'), 'text/txt'}
  #   user_id FactoryGirl.create(:user).id
  # end
end