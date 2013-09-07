require 'spec_helper'

describe User do
  before :each do
    @attr = { :email => "user@example.com" }
    @user = User.new(@attr)
  end

  it "should have an email attribute" do
    @user.should respond_to(:email)
  end

  it "should have an admin attribute" do
    @user.should respond_to(:admin)
  end

  it "should have a password attribute" do
    @user.should respond_to(:password)
  end

  # email validations
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should refuse invalid email addresses" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should accept valid email addresses" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  # TODO test user uniqueness
end