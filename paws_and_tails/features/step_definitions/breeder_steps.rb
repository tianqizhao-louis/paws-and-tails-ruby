Given /the following breeders exist/ do |breeders_table|
  breeders_table.hashes.each do |breeder|
    Breeder.create breeder
  end

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

  User.create!("user_name": "test_4",
               "password": "test",
               "user_type": "breeder")
end

Then(/(.*) seed breeders should exist/) do | n_seeds |
  expect(Breeder.count).to eq n_seeds.to_i
end

Given("I am on the breeders page") do
  visit '/breeders'
end

Given(/I am on the breeder details page of "([^"]*)"$/) do | breeder_name |
  visit breeder_path(Breeder.where("name=?", breeder_name).first)
end

When("I create some sample animal data") do
  Animal.create!("name": "Bobby",
                 "animal_type": "Cat",
                 "breed": "Ragdoll",
                 "price": 100,
                 "anticipated_birthday": "2023-09-01",
                 "breeder_id": 2,
                 "image_link": "/test/image/jpg")
end

When(/I visit this breeder's page: "([^"]*)"$/) do | breeder |
  click_link(breeder)
end

When(/^(?:|I )click the link of "([^"]*)" on this breeder's page$/) do | link |
  click_link(link)
end

When(/^(?:|I )click the button of "([^"]*)" on this breeder's page$/) do | button |
  click_button(button)
end

When(/^(?:|I )fill in "([^"]*)" with "([^"]*)" on the breeder's page$/) do |field, value|
  fill_in(field, :with => value)
end

Then(/I should see an input field of "([^"]*)" with "([^"]*)" on breeder's page$/) do | field_name, field_content |
  expect(page).to have_field(field_name, with: field_content)
end



# # Make sure that one string (regexp) occurs before or after another one
# #   on the same page
#
# Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
#   #  ensure that that e1 occurs before e2.
#   #  page.body is the entire content of the page as a string.
#   page.body.index(e1).should < page.body.index(e2)
# end
# #
# # When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
# #   # HINT: use String#split to split up the rating_list, then
# #   #   iterate over the ratings and reuse the "When I check..." or
# #   #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
# #   # pending "Fill in this step in movie_steps.rb"
# #   rating_list_split = rating_list.split(', ')
# #   if uncheck
# #     # uncheck
# #     # rating_list_split.each { |each_rating|
# #     #   uncheck "ratings_" + each_rating
# #     # }
# #     rating_list_split.each { |each_rating|
# #       steps %Q{
# #         When I uncheck the "#{each_rating}" checkbox
# #       }
# #       # When %{I uncheck the "#{each_rating}" checkbox}
# #       # Then %{the #{each_rating} checkbox should not be checked}
# #     }
# #   else
# #     # check
# #     # rating_list_split.each { |each_rating|
# #     #   check "ratings_" + each_rating
# #     # }
# #     rating_list_split.each { |each_rating|
# #       steps %Q{
# #         When I check the "#{each_rating}" checkbox
# #       }
# #       # When %{I check the "#{each_rating}" checkbox}
# #       # Then %{the #{each_rating} checkbox should be checked}
# #     }
# #   end
# # end
#
# When /^(?:|I )click the "([^"]*)"$/ do |button|
#   click_button button
# end

Then(/I should (not )?see "([^"]*)" on breeder's page$/) do | no, content |
  if !no
    expect(page).to have_content(content)
  else
    expect(page).to_not have_content(content)
  end
end


Then(/^I should (not )?see the following breeders: (.*)$/) do |no, breeder_list|
  # Take a look at web_steps.rb Then /^(?:|I )should see "([^"]*)"$/

  breeder_list_split = breeder_list.split(", ")
  if no
    # not see
    breeder_list_split.each { |each_breeder|
      expect(page).not_to have_content(each_breeder)
    }
  else
    breeder_list_split.each { |each_breeder|
      expect(page).to have_content(each_breeder)
    }
  end
end

#
# Then /I should see all the breeders/ do
#   # Make sure that all the movies in the app are visible in the table
#   # pending "Fill in this step in movie_steps.rb"
#   # expect(Movie.count).to eq n_seeds.to_i
#   expect(page.body).to have_selector("tr", count: Breeder.count+1)
# end
#
# ### Utility Steps Just for this assignment.
#
# Then /^debug$/ do
#   # Use this to write "Then debug" in your scenario to open a console.
#   require "byebug"; byebug
#   1 # intentionally force debugger context in this method
# end
#
# Then /^debug javascript$/ do
#   # Use this to write "Then debug" in your scenario to open a JS console
#   page.driver.debugger
#   1
# end
#
#
# Then /complete the rest of of this scenario/ do
#   # This shows you what a basic cucumber scenario looks like.
#   # You should leave this block inside movie_steps, but replace
#   # the line in your scenarios with the appropriate steps.
#   fail "Remove this step from your .feature files"
# end
