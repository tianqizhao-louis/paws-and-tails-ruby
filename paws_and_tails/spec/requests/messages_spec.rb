require 'rails_helper'

RSpec.describe "Messages", type: :request do
  before(:each) do
    Breeder.create!("name": "Northwestern Wildcats",
                    "city": "Evanston",
                    "country": "United States",
                    "price_level": "$$$",
                    "address": "2400 Sheridan Road, Evanston, IL",
                    "email": "test@test.com")
    User.create!("user_name": "breeder_test",
                 "password": "breeder",
                 "user_type": "breeder")
    UserToBreeder.create!("user_id": 1,
                          "breeder_id": 1)

    User.create!("user_name": "normal_user",
                 "password": "user",
                 "user_type": "petfinder")

    Breeder.create!("name": "Not Associated With User",
                    "city": "Evanston",
                    "country": "United States",
                    "price_level": "$$$",
                    "address": "2400 Sheridan Road, Evanston, IL",
                    "email": "test@test.com")

    ENV['stub_user_id'] = nil
  end

  describe "POST /messages/api/new" do
    it "should send message" do
      ENV['stub_user_id'] = "2"

      post "/messages/api/new", xhr: true, :params => {:message => {from_user_id: "2", to_user_id: "1", content: "Hello"}}
      expect(response).to have_http_status(:success)

      expect(Message.where(from_user_id: "2", to_user_id: "1")).not_to be_nil
    end
  end

  describe "GET /messages/inbox/show" do
    it "should get message inbox" do
      ENV['stub_user_id'] = "2"

      post "/messages/api/new", xhr: true, :params => {:message => {from_user_id: "2", to_user_id: "1", content: "Hello"}}
      expect(response).to have_http_status(:success)

      post "/messages/api/new", xhr: true, :params => {:message => {from_user_id: "1", to_user_id: "2", content: "Hey there"}}
      expect(response).to have_http_status(:success)

      get("/messages/inbox/show")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /messages/:to_user_id" do
    it "should render messaging template for existing user" do
      ENV['stub_user_id'] = "2"

      get("/messages/1")
      expect(response).to have_http_status(200)

      visit("/messages/1")
      expect(page).to have_content("Private Message with breeder_test")
    end

    it "should not render messaging for nonexistent breeder" do
      ENV['stub_user_id'] = "2"

      get("/messages/-1")
      expect(response).to have_http_status(200)

      visit("/messages/-1")
      expect(page).to have_content("Failed to retrieve messages")
    end
  end
end
