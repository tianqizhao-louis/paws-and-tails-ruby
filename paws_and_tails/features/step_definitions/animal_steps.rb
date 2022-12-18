Given(/the following animals exist/) do |animals_table|
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

  animals_table.hashes.each do |animal|
    Animal.create animal
  end
end

Given("I am on the animals page") do
  visit '/animals'
end

Given(/I am on the animal details page of "([^"]*)"$/) do | animal_name |
  visit animal_path(Animal.where("name=?", animal_name).first)
end

When(/^(?:|I )click the link of "([^"]*)" on this animal's page$/) do | link |
  click_link(link)
end

Given("I am on the login page") do
  visit '/login'
end

When(/^(?:|I )click the button of "([^"]*)" on this animal's page$/) do | button |
  click_button(button)
end

Then(/(.*) seed animals should exist/) do | n_seeds |
  expect(Animal.count).to eq n_seeds.to_i
end

Then(/^I should (not )?see the following animals: (.*)$/) do |no, animal_list|
  animal_list_split = animal_list.split(", ")
  if no
    # not see
    animal_list_split.each { |each_animal|
      expect(page).not_to have_content(each_animal)
      # steps %Q{
      #   Then I should not see "#{each_animal}"
      #       }
    }
  else
    animal_list_split.each { |each_animal|
      expect(page).to have_content(each_animal)
      # steps %Q{
      # Then I should see "#{each_animal}"
      #       }
    }
  end
end

When(/I visit this animal's page: "([^"]*)"$/) do | animal |
  click_link(animal)
end

Then(/I should (not )?see "([^"]*)" on animal's page$/) do | no, content |
  if !no
    expect(page).to have_content(content)
  else
    expect(page).to_not have_content(content)
  end
end

Then(/I should see an input field of "([^"]*)" with "([^"]*)" on animal's page$/) do | field_name, field_content |
  expect(page).to have_field(field_name, with: field_content)
end

When(/^(?:|I )fill in "([^"]*)" with "([^"]*)" on the animal's page$/) do |field, value|
  fill_in(field, :with => value)
end

When(/I constraint the search of "([^"]*)" with "([^"]*)" on the animal's page$/) do | constraint, content |
  page.execute_script("document.querySelector('#current-#{constraint}').innerText='#{content}'")
  # find("#dropdown-#{constraint}-select-#{content}", visible: :all).click_link
  expect(page).to have_css "#current-#{constraint}", text: content
end

When(/^(?:|I )click the button to refine search on animals' page$/) do
  expect(page).to have_css "#submit-location"
  find("#submit-location").click
  # page.execute_script("sendFetchToAnimals(document.querySelector('#current-city').innerText, document.querySelector('#current-country').innerText, 'Any');")
end

When(/^(?:|I )sort the animal page by "([^"]*)"$/) do | criteria |
  if criteria == "price"
    expect(page).to have_css "#sort-price"
    find("#sort-price").click
  elsif criteria == "city"
    expect(page).to have_css "#sort-city"
    find("#sort-city").click
  elsif criteria == "breeder"
    expect(page).to have_css "#sort-breeder_id"
    find("#sort-breeder_id").click
  end
end

Then(/^(?:|I )should see "([^"]*)" appears before "([^"]*)" on the animals page$/) do | e1, e2 |
  # expect(page.body) =~ /#{e1}.*#{e2}/
  expect(e1).to appear_before(e2)
end