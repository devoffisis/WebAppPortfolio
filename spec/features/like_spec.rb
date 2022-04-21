require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  scenario "Like a post" do
    user = FactoryBot.create :user
    post = FactoryBot.create :post, user: user

    visit "/"
    click_link 'Login'
    fill_in "user[email]",	with: user.email
    fill_in "user[password]",	with: user.password
    click_button 'サインインする'

    expect(page).to have_button('いいね')
    #find_by_id('like-1') # TODO idで取りたいが取れない
    click_on 'いいね'
    expect(user.posts[0].likes.length).to eq(1)
  end
end
