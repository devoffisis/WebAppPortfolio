require 'rails_helper'

RSpec.describe 'SignUps', type: :request do
  describe 'signup' do
    it 'checks to sign up' do
      # URLは登録フォームのactionで調べよう
      post '/users', params: {
        user: {
          email: 'test@example.co.jp',
          name: 'testuser',
          password: '123456',
          password_confirmation: '123456'
        }
      }
      expect(response).to redirect_to root_path

      user = User.find_by name: 'testuser'
      expect(user).to be_valid
      expect(user.name).to eq('testuser')
    end
  end
end
