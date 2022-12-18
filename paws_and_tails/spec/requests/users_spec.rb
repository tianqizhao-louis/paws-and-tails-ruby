require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "New User" do
    it "should render new user page" do
      ENV['stub_user_id'] = nil
      get("/signup")
      expect(response).to have_http_status(200)
    end

    it "should let not logged in user to sign up" do
      ENV['stub_user_id'] = nil

      post("/users", params: {
        :user => {
          "user_name": "normal_user",
          "password": "user",
          "password_confirmation": "user",
          "user_type": "petfinder"
        },
        type_id: "petfinder"
      })

      expect(response).to redirect_to root_url
    end

    it "redirect if cannot save" do
      allow_any_instance_of(User).to receive(:valid?).and_return(false)

      ENV['stub_user_id'] = nil

      post("/users", params: {
        :user => {
          "user_name": "normal_user",
          "password": "user",
          "password_confirmation": "user",
          "user_type": "petfinder"
        },
        type_id: "petfinder"
      })

      expect(response).to have_http_status(200)
    end
  end

  describe "View Profile" do
    it "should let user view profile" do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "breeder")
      ENV['stub_user_id'] = "1"

      get("/users/1")
      expect(response).to have_http_status(200)
    end

    it "should not let user view others' profile" do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "breeder")
      ENV['stub_user_id'] = "1"

      get("/users/2")
      expect(response).to redirect_to root_url
    end
  end

  describe "Login/Logout" do
    before(:each) do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "petfinder")
      ENV['stub_user_id'] = nil
    end

    it "should let user login" do
      post("/login/create", params: {
        user_name: "test_1",
        password: "test"
      })
      expect(response).to redirect_to root_url
    end

    it "should not let user login if incorrect username or password" do
      post("/login/create", params: {
        user_name: "test_1",
        password: "wrongpassword"
      })
      expect(flash[:warning]).to eq "Email or password is invalid"
    end

    it "should let user logout" do
      ENV['stub_user_id'] = "1"

      get("/logout")
      expect(response).to redirect_to root_url
    end
  end
end
