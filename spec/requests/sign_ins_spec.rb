require 'rails_helper'

RSpec.describe "SignIns", type: :request do
  describe "login" do
    let (:user) { FactoryBot.create(:user, email: 'newuser@example.co.jp', password: "12345678")}

    it "checks displaying the login view" do
      get "/users/sign_in"
      expect(response).to have_http_status(200)
    end

    it "checks to see if we can login" do
      post "/users/sign_in", params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
      expect(response).to redirect_to root_path
    end

    it "checks to see if we cannot login" do
      post "/users/sign_in", params: {
        user: {
          email: "nodummyuser@example.co.jp",
          password: "12345678"
        }
      }
      expect(response.body).to include("Invalid Email or password.")
    end
  end
end
