require 'rails_helper'

RSpec.describe Post, type: :model do
  it "checks that a comment is mandetory" do
    user = User.new(name: "test", email: "a@example.com", password: "123456", password_confirmation: "123456")
    post = user.posts.build(caption: "cap", image: "1.png")
    expect(post).to be_valid
  end
end
