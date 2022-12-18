require 'rails_helper'

RSpec.describe "Application", type: :request do

  describe "authorize" do
    it "should not let unauthorized user bypass security wall" do
      ENV['stub_user_id'] = nil

      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")

      get("/breeders/1/edit")
      expect(response).to redirect_to login_url
    end
  end

  describe "un-routed" do
    it "should route to 404 if no matched routes" do
      visit("/hahaha")
      expect(page).to have_content("404")
    end
  end
end