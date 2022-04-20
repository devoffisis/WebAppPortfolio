require 'rails_helper'

RSpec.feature "Projects", type: :feature do
    let (:user) { FactoryBot.create(:user, email: 'messageuser@example.co.jp', password: '12345678') }

    scenario "Post a message" do
      visit "/"
      click_link 'Login'
      expect(page.current_path).to eq '/users/sign_in'

      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'サインインする'
      expect(page.current_path).to eq root_path

      click_link '投稿'
      expect(page.current_path).to eq '/posts/new'

      expect(page).to have_button('投稿')
      post = Post.new(user: user, caption: 'Test Message')
      fill_in 'post[caption]', with: post.caption
      attach_file('post[image]', "#{Rails.root}/spec/fixtures/sample.png" )
      click_button '投稿'
      expect(page.current_path).to eq '/posts'

      expect(page).to have_selector("img[src$='sample.png']")
      within first('p.mb-0') do
        expect(text).to eq post.caption
      end
    end
end
