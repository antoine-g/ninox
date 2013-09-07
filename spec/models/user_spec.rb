require 'spec_helper'

describe User do
  before :each do
    @attr = { :email => "user@example.com", :password => "password", :password_confirmation => "password" }
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

  describe "password validations:" do
    it "should require a password" do
      no_password_user = User.new(@attr.merge(:password => ""))
      no_password_user.should_not be_valid
    end

    it "should require a valid password_confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
      should_not be_valid
    end

    it "should reject too short password" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject too long password" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
end