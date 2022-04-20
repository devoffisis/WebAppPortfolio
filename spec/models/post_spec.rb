require 'rails_helper'

# https://qiita.com/motty93/items/5cbc46ce79a502fcaa65
# CarrierWaveを使ったときのテスト

RSpec.describe Post, type: :model do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/sample.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    @user = User.create(name: 'test', email: 'a@example.com', password: '123456', password_confirmation: '123456')
  end

  it 'checks that a comment is mandetory' do
    post = @user.posts.build(caption: 'cap', image: image)
    expect(post).to be_valid

    post = @user.posts.build(caption: '', image: image)
    post.valid?
    expect(post.errors[:caption]).to include("can't be blank")
  end

  it 'checks a caption length' do
    post = @user.posts.build(caption: (1..255).map{'a'}.join, image: image)
    expect(post).to be_valid

    post = @user.posts.build(caption: (1..256).map{'a'}.join, image: image)
    post.valid?
    expect(post.errors[:caption]).to include('is too long (maximum is 255 characters)')
  end
end
