require 'rails_helper'

RSpec.describe "Breeders", type: :request do
  before(:each) do
    ENV['stub_user_id'] = nil
  end


  describe "GET /index" do
    it "should get index" do
      get("/breeders")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "should show breeder" do
      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")
      get("/breeders/#{new_breeder.id}")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    it "should render new breeder template" do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "breeder")
      ENV['stub_user_id'] = "1"

      Breeder.new
      get("/breeders/new")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    before(:each) do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "breeder")
      ENV['stub_user_id'] = "1"
    end

    it "should render edit breeder template" do
      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")
      get("/breeders/#{new_breeder.id}/edit")
      # expect(assigns(:breeder)).to eql new_breeder
      expect(response).to have_http_status(200)

      visit "/breeders/#{new_breeder.id}/edit"
      expect(page).to have_content("Edit Breeder")
    end
  end

  describe "POST /create" do
    before(:each) do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "breeder")
      ENV['stub_user_id'] = "1"
    end

    it "should create a new breeder" do
      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")
      expect(Breeder.find_by(name: "Ragdoll Breeder")).not_to be_nil
    end

    it "cannot find nonexistent breeder" do
      expect(Breeder.find_by(name: "Not Exist")).to be_nil
    end

    it "create and redirect" do
      post("/breeders", params: {
        breeder: {"name": "Ragdoll Breeder",
                  "city": "Boston",
                  "country": "United States",
                  "price_level": "$$$",
                  "address": "Hello Street, Boston, MA",
                  "email": "breeder@email.com"}
      })
      expect(response).to redirect_to "/breeders/1"
    end

    it "redirect if cannot save" do
      allow_any_instance_of(Breeder).to receive(:valid?).and_return(false)

      post("/breeders", params: {
        breeder: {"name": "Ragdoll Breeder",
                  "city": "Boston",
                  "country": "United States",
                  "price_level": "$$$",
                  "address": "Hello Street, Boston, MA",
                  "email": "breeder@email.com"}
      })
      expect(response).to have_http_status(200)
    end

    it "should not allow create breeder if already linked" do
      ENV['stub_user_id'] = "1"

      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")
      UserToBreeder.create!("user_id": 1,
                            "breeder_id": 1)

      get("/breeders/new")
      expect(response).to redirect_to root_url
    end

    it "should not allow create breeder if not breeder" do
      User.create!("user_name": "normal_user",
                   "password": "user",
                   "user_type": "petfinder")

      ENV['stub_user_id'] = "2"

      get("/breeders/new")
      expect(response).to redirect_to root_url
    end
  end

  describe "PUT /update" do
    before(:each) do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "breeder")
      ENV['stub_user_id'] = "1"
    end

    it "update the corresponding breeder" do
      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")
      put("/breeders/#{new_breeder.id}", params: {
        breeder: {country: "England"}
      })
      new_breeder.reload
      expect(new_breeder.country).to eq "England"
    end

    it "doesn't update and redirect if invalid id" do
      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")
      allow_any_instance_of(Breeder).to receive(:valid?).and_return(false)

      put("/breeders/#{new_breeder.id}", params: {
        breeder: {country: "England"}
      })
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /delete" do
    before(:each) do
      User.create!("user_name": "test_1",
                   "password": "test",
                   "user_type": "breeder")
      ENV['stub_user_id'] = "1"
    end

    it "delete a created breeder" do
      new_breeder = Breeder.create!("name": "Ragdoll Breeder",
                                    "city": "Boston",
                                    "country": "United States",
                                    "price_level": "$$$",
                                    "address": "Hello Street, Boston, MA",
                                    "email": "breeder@email.com")
      get "/breeders/redesigned_destroy/" + new_breeder.id.to_s
      expect(Breeder.find_by(name: "Test Breeder")).to be_nil
      expect(response).to redirect_to breeders_url
    end
  end
end
