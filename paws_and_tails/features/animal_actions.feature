Feature: display and interact with a list of animals

  Background: animals have been added to the database

    Given the following animals exist:
      | name              | animal_type  | breed            | price | anticipated_birthday | breeder_id |
      | Sleeping Pajamas  | Dog          | Labrador         | 600   | 2022-12-01           | 1          |
      | Hello Kitty       | Cat          | Ragdoll          | 100   | 2023-09-01           | 2          |
      | Parody            | Bird         | Parrot           | 15    | 2022-12-13           | 1          |

    And  I am on the animals page
    Then 3 seed animals should exist

  Scenario: displaying animals
    Given I am on the animals page
    Then I should see the following animals: Sleeping Pajamas, Hello Kitty, Parody
    And I should not see the following animals: Hans, Yuki, Ivan

  Scenario: visiting animal's page
    Given I am on the animals page
    When I visit this animal's page: "Sleeping Pajamas"
    Then I should see "Animal: Sleeping Pajamas" on animal's page
    And I should see "Dog" on animal's page

  Scenario: opening edit page and editing
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "test_1" on the animal's page
    When I fill in "Password" with "test" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    When I click the link of "Edit" on this animal's page
    Then I should see "Edit Animal" on animal's page
    Then I should see an input field of "Animal Name" with "Sleeping Pajamas" on animal's page
    Then I should see an input field of "Animal Type" with "Dog" on animal's page
    When I fill in "Animal Name" with "Hans" on the animal's page
    And I fill in "Price" with "550" on the animal's page
    And I click the button of "Submit" on this animal's page
    Then I should see "Animal was successfully updated." on animal's page
    And I should see "Hans" on animal's page
    And I should see "550" on animal's page
    Then I click the link of "Back" on this animal's page
    And I should see "Hans" on animal's page

  Scenario: canceling edit
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "test_1" on the animal's page
    When I fill in "Password" with "test" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    When I click the link of "Edit" on this animal's page
    Then I should see "Edit Animal" on animal's page
    Then I should see an input field of "Animal Name" with "Sleeping Pajamas" on animal's page
    Then I should see an input field of "Animal Type" with "Dog" on animal's page
    When I fill in "Animal Name" with "Hans" on the animal's page
    And I fill in "Price" with "550" on the animal's page
    And I click the link of "Cancel" on this animal's page
    Then I should not see "Animal was successfully updated." on animal's page
    And I should see "Sleeping Pajamas" on animal's page
    When I visit this animal's page: "Sleeping Pajamas"
    And I should see "600" on animal's page

  Scenario: deleting animal
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "test_1" on the animal's page
    When I fill in "Password" with "test" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    When I click the link of "Delete" on this animal's page
    Then I should see "Animal was successfully destroyed." on animal's page
    And I should not see "Sleeping Pajamas" on animal's page

  Scenario: adding a new animal
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "test_1" on the animal's page
    When I fill in "Password" with "test" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animals page
    When I click the link of "My Profile" on this animal's page
    Then I click the link of "Go to my breeder profile" on this animal's page
    Then I should see "New Animal" on animal's page
    Then I click the link of "New Animal" on this animal's page
    When I fill in "Animal Name" with "Good Morning" on the animal's page
    And I fill in "Animal Type" with "Frog" on the animal's page
    And I fill in "Animal Breed" with "Goldfish" on the animal's page
    And I fill in "Price" with "150" on the animal's page
    And I fill in "Anticipated Birthday" with "2023-09-01" on the animal's page
    And I click the button of "Submit" on this animal's page
    Then I should see "Animal was successfully created." on animal's page
    And I should see "Good Morning" on animal's page
    And I should see "Frog" on animal's page
    And I should see "Goldfish" on animal's page
    And I should see "Northwestern Wildcats" on animal's page
    Then I click the link of "Back" on this animal's page
    And I should see "Good Morning" on animal's page

  @javascript
  Scenario: refine the search by city
    Given I am on the animals page
    When I constraint the search of "city" with "Montreal" on the animal's page
    When I click the button to refine search on animals' page
    And I should see "Hello Kitty" on animal's page
    And I should not see "Parody" on animal's page
    And I should not see "Sleeping Pajamas" on animal's page

  @javascript
  Scenario: refine the search by country
    Given I am on the animals page
    When I constraint the search of "country" with "United States" on the animal's page
    When I click the button to refine search on animals' page
    And I should see "Sleeping Pajamas" on animal's page
    And I should see "Parody" on animal's page
    And I should not see "Hello Kitty" on animal's page

  @javascript
  Scenario: refine the search by city and country
    Given I am on the animals page
    When I constraint the search of "city" with "Montreal" on the animal's page
    When I constraint the search of "country" with "Canada" on the animal's page
    When I click the button to refine search on animals' page
    And I should see "Hello Kitty" on animal's page
    And I should not see "Sleeping Pajamas" on animal's page
    And I should not see "Parody" on animal's page

  @javascript
  Scenario: sort by breed
    Given I am on the animals page
    When I sort the animal page by "price"
    Then I should see "Parody" appears before "Hello Kitty" on the animals page
    Then I should see "Parody" appears before "Sleeping Pajamas" on the animals page
    Then I should see "Hello Kitty" appears before "Sleeping Pajamas" on the animals page

  @javascript
  Scenario: sort by city
    Given I am on the animals page
    When I sort the animal page by "city"
    Then I should see "Sleeping Pajamas" appears before "Hello Kitty" on the animals page
    Then I should see "Parody" appears before "Hello Kitty" on the animals page

  @javascript
  Scenario: sort by breeder
    Given I am on the animals page
    When I sort the animal page by "breeder"
    Then I should see "Parody" appears before "Hello Kitty" on the animals page