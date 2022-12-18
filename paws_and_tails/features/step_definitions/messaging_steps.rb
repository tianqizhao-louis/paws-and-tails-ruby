Given("I have breeders and petfinders") do
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
end

When(/^(?:|I )type the message "([^"]*)"$/) do | m |
  expect(page).to have_css "#send-message-input-area"
  find("#send-message-input-area").send_keys(m)
end
