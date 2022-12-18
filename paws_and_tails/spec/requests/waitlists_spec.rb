require 'rails_helper'

RSpec.describe "Waitlists", type: :request do
  before(:each) do
    Breeder.create!("name": "Northwestern Wildcats",
                    "city": "Evanston",
                    "country": "United States",
                    "price_level": "$$$",
                    "address": "2400 Sheridan Road, Evanston, IL",
                    "email": "test@test.com")
    Breeder.create!("name": "Rainbow Lively",
                    "city": "Montreal",
                    "country": "Canada",
                    "price_level": "$",
                    "address": "Rogers Bank Street, Montreal, Quebec",
                    "email": "test@test.com")

    User.create!("user_name": "test_1",
                 "password": "test",
                 "user_type": "breeder")

    User.create!("user_name": "test_2",
                 "password": "test",
                 "user_type": "breeder")

    User.create!("user_name": "normal_user",
                 "password": "user",
                 "user_type": "petfinder")

    UserToBreeder.create!("user_id": 1,
                          "breeder_id": 1)

    UserToBreeder.create!("user_id": 2,
                          "breeder_id": 2)
  end

  describe "POST /waitlists/join" do
    before(:each) do
      Animal.create!("name": "Chimelu",
                     "animal_type": "Dog",
                     "breed": "Chihuahua",
                     "price": 374.5,
                     "anticipated_birthday": "2022-12-18",
                     "breeder_id": 1,
                     "image_link": "/test/image/jpg")
    end

    it "should let user join waitlist" do
      ENV['stub_user_id'] = "3"

      post "/waitlists/join", xhr: true, :params => {:waitlist => {animal_id: 1, user_id: 3}}

      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["current_place"]).to eq(1)
      expect(parsed_body["total_place"]).to eq(1)
    end
  end

  describe "POST /waitlists/leave" do
    before(:each) do
      Animal.create!("name": "Chimelu",
                     "animal_type": "Dog",
                     "breed": "Chihuahua",
                     "price": 374.5,
                     "anticipated_birthday": "2022-12-18",
                     "breeder_id": 1,
                     "image_link": "/test/image/jpg")
      ENV['stub_user_id'] = "3"

      post "/waitlists/join", xhr: true, :params => {:waitlist => {animal_id: 1, user_id: 3}}
    end

    it "should let user leave waitlist" do
      ENV['stub_user_id'] = "3"

      post "/waitlists/leave", xhr: true, :params => {:waitlist => {animal_id: 1, user_id: 3}}

      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["status"]).to eq("left")
    end
  end

  describe "GET /waitlists/manage/remove/:user_id/:animal_id" do
    before(:each) do
      Animal.create!("name": "Chimelu",
                     "animal_type": "Dog",
                     "breed": "Chihuahua",
                     "price": 374.5,
                     "anticipated_birthday": "2022-12-18",
                     "breeder_id": 1,
                     "image_link": "/test/image/jpg")
      ENV['stub_user_id'] = "3"

      post "/waitlists/join", xhr: true, :params => {:waitlist => {animal_id: 1, user_id: 3}}
    end

    it "should let breeder manage waitlist" do
      ENV['stub_user_id'] = "1"

      get "/waitlists/manage/remove/3/1"
      expect(response).to redirect_to "/animals/1"
    end
  end

  describe "GET /animals/:animal_id" do
    before(:each) do
      Animal.create!("name": "Chimelu",
                     "animal_type": "Dog",
                     "breed": "Chihuahua",
                     "price": 374.5,
                     "anticipated_birthday": "2022-12-18",
                     "breeder_id": 1,
                     "image_link": "/test/image/jpg")
      ENV['stub_user_id'] = "3"

      post "/waitlists/join", xhr: true, :params => {:waitlist => {animal_id: 1, user_id: 3}}
    end

    it "should let user see waitlist after joining" do
      ENV['stub_user_id'] = "3"
      visit("/animals/1")
      expect(page).to have_content("Your current position")
    end
  end
end
