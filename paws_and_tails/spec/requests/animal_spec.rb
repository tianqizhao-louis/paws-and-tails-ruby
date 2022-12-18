require 'rails_helper'

RSpec.describe "Animals", type: :request do
  before(:each) do
    Breeder.create!("name": "Ragdoll Breeder",
                    "city": "Boston",
                    "country": "United States",
                    "price_level": "$$$",
                    "address": "Hello Street, Boston, MA",
                    "email": "breeder@email.com")
    Breeder.create!("name": "New China Pets",
                    "city": "Beijing",
                    "country": "China",
                    "price_level": "$",
                    "address": "Sanyuanqiao, Beijing, China",
                    "email": "test@test.com")
    Breeder.create!("name": "Rainbow Lively",
                    "city": "Montreal",
                    "country": "Canada",
                    "price_level": "$$$",
                    "address": "Rogers Bank Street, Montreal, Quebec",
                    "email": "test@test.com")

    User.create!("user_name": "test_1",
                 "password": "test",
                 "user_type": "breeder")

    User.create!("user_name": "test_2",
                 "password": "test",
                 "user_type": "breeder")

    User.create!("user_name": "test_3",
                 "password": "test",
                 "user_type": "breeder")

    UserToBreeder.create!("user_id": 1,
                          "breeder_id": 1)

    UserToBreeder.create!("user_id": 2,
                          "breeder_id": 2)

    UserToBreeder.create!("user_id": 3,
                          "breeder_id": 3)

    ENV['stub_user_id'] = nil
  end

  describe "GET /index" do
    # pending "add some examples (or delete) #{__FILE__}"
    it "should get index" do
      get("/animals")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do
    it "should show animal" do
      new_animal = Animal.create!("name": "Hello Kitty",
                                  "animal_type": "Cat",
                                  "breed": "Ragdoll",
                                  "price": 100,
                                  "anticipated_birthday": "2023-09-01",
                                  "breeder_id": 1,
                                  "image_link": "/test/image/jpg")
      get("/animals/#{new_animal.id}")
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    it "should render new animal template" do
      ENV['stub_user_id'] = "1"
      get '/animals/new'
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /edit" do
    it "should render edit animal template" do
      ENV['stub_user_id'] = "1"

      new_animal = Animal.create!("name": "Hello Kitty",
                                  "animal_type": "Cat",
                                  "breed": "Ragdoll",
                                  "price": 100,
                                  "anticipated_birthday": "2023-09-01",
                                  "breeder_id": 1,
                                  "image_link": "/test/image/jpg")
      get("/animals/#{new_animal.id}/edit")
      expect(response).to have_http_status(200)

      visit "/animals/#{new_animal.id}/edit"
      expect(page).to have_content("Edit Animal")
    end
  end

  describe "POST /create" do
    before(:each) do
      ENV['stub_user_id'] = "1"
    end
    it "should create a new animal" do
      new_animal = Animal.create!("name": "Hello Kitty",
                                  "animal_type": "Cat",
                                  "breed": "Ragdoll",
                                  "price": 100,
                                  "anticipated_birthday": "2023-09-01",
                                  "breeder_id": 1,
                                  "image_link": "/test/image/jpg")
      expect(Animal.find_by(name: "Hello Kitty")).not_to be_nil
    end

    it "cannot find nonexistent animal" do
      expect(Animal.find_by(name: "Not Exist")).to be_nil
    end

    it "create and redirect" do
      ENV['stub_user_id'] = "1"
      post("/animals", params: {
        animal: {"name": "Hello Kitty",
                  "animal_type": "Cat",
                  "breed": "Ragdoll",
                  "price": 100,
                  "anticipated_birthday": "2023-09-01",
                 "image_link": "/test/image/jpg"}
      })
      expect(response).to redirect_to "/animals/1"
    end

    it "redirect if cannot save" do
      allow_any_instance_of(Animal).to receive(:valid?).and_return(false)

      post("/animals", params: {
        animal: {"name": "Hello Kitty",
                 "animal_type": "Cat",
                 "breed": "Ragdoll",
                 "price": 100,
                 "anticipated_birthday": "2023-09-01",
                 "breeder_id": 1,
                 "image_link": "/test/image/jpg"}
      })
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /update" do
    before(:each) do
      ENV['stub_user_id'] = "1"
    end
    it "update the corresponding animal" do
      new_animal = Animal.create!("name": "Hello Kitty",
                                  "animal_type": "Cat",
                                  "breed": "Ragdoll",
                                  "price": 100,
                                  "anticipated_birthday": "2023-09-01",
                                  "breeder_id": 1,
                                  "image_link": "/test/image/jpg")
      put("/animals/#{new_animal.id}", params: {
        animal: {animal_type: "Dog"}
      })
      new_animal.reload
      expect(new_animal.animal_type).to eq "Dog"
    end

    it "doesn't update and redirect if invalid id" do
      new_animal = Animal.create!("name": "Hello Kitty",
                                  "animal_type": "Cat",
                                  "breed": "Ragdoll",
                                  "price": 100,
                                  "anticipated_birthday": "2023-09-01",
                                  "breeder_id": 1,
                                  "image_link": "/test/image/jpg")
      allow_any_instance_of(Animal).to receive(:valid?).and_return(false)

      put("/animals/#{new_animal.id}", params: {
        animal: {animal_type: "Dog"}
      })
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /delete" do
    it "delete a created animal" do
      ENV['stub_user_id'] = "1"
      new_animal = Animal.create!("name": "Hello Kitty",
                                  "animal_type": "Cat",
                                  "breed": "Ragdoll",
                                  "price": 100,
                                  "anticipated_birthday": "2023-09-01",
                                  "breeder_id": 1,
                                  "image_link": "/test/image/jpg")
      get "/animals/redesigned_destroy/" + new_animal.id.to_s
      expect(Animal.find_by(name: "Kitty")).to be_nil
      expect(response).to redirect_to animals_url
    end
  end

  describe "POST /animals/api/sort_location, sort animals" do
    before(:each) do
      Animal.create!("name": "Hello Kitty",
                     "animal_type": "Cat",
                     "breed": "Ragdoll",
                     "price": 100,
                     "anticipated_birthday": "2023-09-01",
                     "breeder_id": 1,
                     "image_link": "/test/image/jpg")
      Animal.create!("name": "Brady",
                     "animal_type": "Dog",
                     "breed": "German Shepherd",
                     "price": 1200,
                     "anticipated_birthday": "2022-12-30",
                     "breeder_id": 3,
                     "image_link": "/test/image/jpg")
      Animal.create!("name": "Chimelu",
                     "animal_type": "Dog",
                     "breed": "Chihuahua",
                     "price": 374.5,
                     "anticipated_birthday": "2022-12-18",
                     "breeder_id": 2,
                     "image_link": "/test/image/jpg")
    end

    it "returns animals sorted by name" do
      post "/animals/api/sort_location", xhr: true, :params => {city: "Any City", country: "Any Country", sorting: "name"}
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["animals"][0]["name"]).to eq("Brady")
      expect(parsed_body["animals"][1]["name"]).to eq("Chimelu")
      expect(parsed_body["animals"][2]["name"]).to eq("Hello Kitty")
    end

    it "returns animals sorted by city" do
      post "/animals/api/sort_location", xhr: true, :params => {city: "Any City", country: "Any Country", sorting: "city"}
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["animals"][0]["name"]).to eq("Chimelu")
      expect(parsed_body["animals"][1]["name"]).to eq("Hello Kitty")
      expect(parsed_body["animals"][2]["name"]).to eq("Brady")
    end

    it "returns animals sorted by price" do
      post "/animals/api/sort_location", xhr: true, :params => {city: "Any City", country: "Any Country", sorting: "price"}
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["animals"][0]["name"]).to eq("Hello Kitty")
      expect(parsed_body["animals"][1]["name"]).to eq("Chimelu")
      expect(parsed_body["animals"][2]["name"]).to eq("Brady")
    end

    it "returns animals sorted by breeder" do
      post "/animals/api/sort_location", xhr: true, :params => {city: "Any City", country: "Any Country", sorting: "breeder_id"}
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["animals"][0]["name"]).to eq("Chimelu")
      expect(parsed_body["animals"][1]["name"]).to eq("Hello Kitty")
      expect(parsed_body["animals"][2]["name"]).to eq("Brady")
    end
  end

  describe "POST /animals/api/sort_location, refine location search" do
    before(:each) do
      Animal.create!("name": "Hello Kitty",
                     "animal_type": "Cat",
                     "breed": "Ragdoll",
                     "price": 100,
                     "anticipated_birthday": "2023-09-01",
                     "breeder_id": 1,
                     "image_link": "/test/image/jpg")
      Animal.create!("name": "Brady",
                     "animal_type": "Dog",
                     "breed": "German Shepherd",
                     "price": 1200,
                     "anticipated_birthday": "2022-12-30",
                     "breeder_id": 3,
                     "image_link": "/test/image/jpg")
      Animal.create!("name": "Chimelu",
                     "animal_type": "Dog",
                     "breed": "Chihuahua",
                     "price": 374.5,
                     "anticipated_birthday": "2022-12-18",
                     "breeder_id": 2,
                     "image_link": "/test/image/jpg")
    end

    it "filters by city" do
      post "/animals/api/sort_location", xhr: true, :params => {city: "Beijing", country: "Any Country", sorting: "Any"}
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["animals"][0]["name"]).to eq("Chimelu")
      expect(parsed_body["animals"].length).to be 1
    end

    it "filters by country" do
      post "/animals/api/sort_location", xhr: true, :params => {city: "Any City", country: "United States", sorting: "Any"}
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["animals"][0]["name"]).to eq("Hello Kitty")
      expect(parsed_body["animals"].length).to be 1
    end

    it "filters by city and country" do
      Animal.create!("name": "Noah",
                     "animal_type": "Cat",
                     "breed": "Wildcat",
                     "price": 1100,
                     "anticipated_birthday": "2022-12-25",
                     "breeder_id": 3,
                     "image_link": "/test/image/jpg")

      post "/animals/api/sort_location", xhr: true, :params => {city: "Montreal", country: "Canada", sorting: "name"}
      expect(response).to have_http_status(:success)
      parsed_body = JSON.parse(response.body)

      expect(parsed_body["animals"][0]["name"]).to eq("Brady")
      expect(parsed_body["animals"][1]["name"]).to eq("Noah")
      expect(parsed_body["animals"].length).to be 2
    end
  end
end
