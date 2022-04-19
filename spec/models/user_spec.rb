require 'rails_helper'

RSpec.describe User, type: :model do
  it "passes validation" do
    user = User.new(name: "foo", email: "foo@example.co.jp", password: "123456", password_confirmation: "123456")
    expect(user).to be_valid
  end

  it "checks double registration" do
    User.create(name: "foobar", email: "foo@example.co.jp", password: "123456", password_confirmation: "123456")
    user = User.new(name: "foobar", email: "foo@example.co.jp", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "checks a name length: less than or equal to 50" do
    user = User.new(name: (1..50).map{"a"}.join, email: "foo@example.co.jp", password: "123456", password_confirmation: "123456")
    expect(user).to be_valid

    user = User.new(name: (1..51).map{"a"}.join, email: "foo@example.co.jp", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end

  it "checks that email is mandetory" do
    user = User.new(name: "test", email: "", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "checks an email length: less than or equal to 255" do
    user = User.new(name: "test", email: "#{(1..243).map{'a'}.join}@example.com", password: "123456", password_confirmation: "123456")
    expect(user).to be_valid

    user = User.new(name: "test2", email: "#{(1..244).map{'a'}.join}@example.com", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end

  it "check an email form: ends with @XXX.XXX" do
    user = User.new(name: "test", email: "a@example.com", password: "123456", password_confirmation: "123456")
    expect(user).to be_valid

    user = User.new(name: "test", email: "@example.com", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")

    user = User.new(name: "test", email: "xexample.com", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")

    user = User.new(name: "test", email: "x@.com", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")

    user = User.new(name: "test", email: "x@example.", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it "check an email form: case-insensitive" do
    user = User.new(name: "test", email: "x@example.", password: "123456", password_confirmation: "123456")
    user = User.new(name: "test", email: "X@example.", password: "123456", password_confirmation: "123456")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
end
