Given("I am on the signup page") do
  visit '/signup'
end

When("I visit unauthorized profile page") do
  visit '/users/999'
end

And(/^(?:|I )select "([^"]*)" user type on the sign up page$/) do | user_type |
  find(:css, "#type_id").find(:option, user_type).select_option
end

And("I want to link with a new breeder") do
  visit '/breeders/new'
end

Given("I visit an un-routed url") do
  visit '/hahaha'
end