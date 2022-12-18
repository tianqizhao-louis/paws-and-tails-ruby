Feature: user signup, login, logout

  Scenario: user signup
    Given I am on the signup page
    Then I should see "Sign Up" on animal's page
    And I fill in "User Name" with "just_another_user" on the animal's page
    And I fill in "Password" with "user" on the animal's page
    And I fill in "Password confirmation" with "user" on the animal's page
    And I click the button of "Sign Up" on this animal's page
    Then I should see "Thank you for signing up!" on animal's page

  Scenario: user shouldn't look at profile when not signing up
    Given I am on the animals page
    Then I visit unauthorized profile page
    And I should see "Not authorized" on animal's page
    Given I am on the signup page
    Then I should see "Sign Up" on animal's page
    And I fill in "User Name" with "just_another_user" on the animal's page
    And I fill in "Password" with "user" on the animal's page
    And I fill in "Password confirmation" with "user" on the animal's page
    And I click the button of "Sign Up" on this animal's page
    Then I should see "Thank you for signing up!" on animal's page
    Then I visit unauthorized profile page
    And I should see "You don't have the permission to view the profile." on animal's page

  Scenario: user shouldn't get logged in if wrong password
    Given I am on the signup page
    Then I should see "Sign Up" on animal's page
    And I fill in "User Name" with "just_another_user" on the animal's page
    And I fill in "Password" with "user" on the animal's page
    And I fill in "Password confirmation" with "user" on the animal's page
    And I click the button of "Sign Up" on this animal's page
    Then I should see "Thank you for signing up!" on animal's page
    And I click the link of "Log Out" on this animal's page
    Given I am on the login page
    Then I should see "Log In" on animal's page
    And I fill in "User Name" with "just_another_user" on the animal's page
    And I fill in "Password" with "wrong_password" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Email or password is invalid" on animal's page

  Scenario: breeder user shouldn't link with two breeders account
    Given I am on the signup page
    Then I should see "Sign Up" on animal's page
    And I fill in "User Name" with "breeder_test" on the animal's page
    And I fill in "Password" with "breeder" on the animal's page
    And I fill in "Password confirmation" with "breeder" on the animal's page
    And I select "breeder" user type on the sign up page
    And I click the button of "Sign Up" on this animal's page
    Then I should see "Thank you for signing up!" on animal's page
    And I click the link of "My Profile" on this breeder's page
    Then I should see "breeder" on breeder's page
    When I click the link of "Link with a Breeder" on this breeder's page
    Then I should see "Add a New Breeder" on breeder's page
    When I fill in "Breeder Name" with "John Doe" on the breeder's page
    And I fill in "Email" with "haha@haha.com" on the breeder's page
    And I fill in "City" with "Beijing" on the breeder's page
    And I fill in "Country" with "China" on the breeder's page
    And I fill in "Price Level" with "$$" on the breeder's page
    And I fill in "Address" with "Hello Street, Waltham, MA" on the breeder's page
    And I click the button of "Submit" on this breeder's page
    Then I should see "Breeder was successfully created." on breeder's page
    And I should see "John Doe" on breeder's page
    And I should see "haha@haha.com" on breeder's page
    And I should see "Beijing" on breeder's page
    And I should see "China" on breeder's page
    And I should see "$$" on breeder's page
    Then I click the link of "Back" on this breeder's page
    And I should see "John Doe" on breeder's page
    And I want to link with a new breeder
    And I should see "You have already linked with a breeder" on breeder's page

  Scenario: normal user shouldn't create a new breeder
    Given I am on the signup page
    Then I should see "Sign Up" on animal's page
    And I fill in "User Name" with "just_another_user" on the animal's page
    And I fill in "Password" with "user" on the animal's page
    And I fill in "Password confirmation" with "user" on the animal's page
    And I click the button of "Sign Up" on this animal's page
    Then I should see "Thank you for signing up!" on animal's page
    And I want to link with a new breeder
    And I should see "You don't have the permission" on breeder's page

  Scenario: application 404
    Given I visit an un-routed url
    And I should see "404" on breeder's page