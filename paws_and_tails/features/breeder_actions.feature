Feature: display and interact with a list of breeders

  Background: breeders have been added to the database

    Given the following breeders exist:
      | name       | city      | country | price_level | address       | email          |
      | HappyPets  | New York  | US      | $$$         | Hello Street  | test@test.com  |
      | PawLine    | London    | UK      | $$          | Golden Street | test@test.com  |
      | InuToNeko  | Tokyo     | Japan   | $           | Love Avenue   | test@test.com  |

    And  I am on the breeders page
    Then 3 seed breeders should exist

  Scenario: displaying breeders
    Given I am on the breeders page
    Then I should see the following breeders: HappyPets, PawLine, InuToNeko
    And I should not see the following breeders: PeppyPets, ClawLine, NekoToInu

  Scenario: visiting a breeder page
    Given I am on the breeders page
    When I visit this breeder's page: "HappyPets"
    Then I should see "Breeder: HappyPets" on breeder's page
    When I create some sample animal data
    Given I am on the breeders page
    When I visit this breeder's page: "PawLine"
    Then I should see "Bobby" on breeder's page

  Scenario: opening edit page and editing
    Given I am on the login page
    Then I should see "Log In" on breeder's page
    When I fill in "User Name" with "test_1" on the breeder's page
    When I fill in "Password" with "test" on the breeder's page
    And I click the button of "Log In" on this breeder's page
    Then I should see "Logged in!" on breeder's page
    Given I am on the breeder details page of "HappyPets"
    And I click the link of "Edit" on this breeder's page
    Then I should see "Edit Breeder" on breeder's page
    Then I should see an input field of "Breeder Name" with "HappyPets" on breeder's page
    Then I should see an input field of "Price Level" with "$$$" on breeder's page
    When I fill in "Breeder Name" with "Good Morning" on the breeder's page
    And I fill in "Country" with "UK" on the breeder's page
    And I click the button of "Submit" on this breeder's page
    Then I should see "Breeder was successfully updated." on breeder's page
    Then I should see "Good Morning" on breeder's page
    Then I should see "UK" on breeder's page
    Then I click the link of "Back" on this breeder's page
    Then I should see "Good Morning" on breeder's page

  Scenario: canceling edit
    Given I am on the login page
    Then I should see "Log In" on breeder's page
    When I fill in "User Name" with "test_1" on the breeder's page
    When I fill in "Password" with "test" on the breeder's page
    And I click the button of "Log In" on this breeder's page
    Then I should see "Logged in!" on breeder's page
    Given I am on the breeder details page of "HappyPets"
    When I click the link of "Edit" on this animal's page
    Then I should see "Edit Breeder" on animal's page
    Then I should see an input field of "Breeder Name" with "HappyPets" on breeder's page
    Then I should see an input field of "Price Level" with "$$$" on breeder's page
    When I fill in "Breeder Name" with "Hans" on the breeder's page
    And I fill in "Price Level" with "$" on the breeder's page
    And I click the link of "Cancel" on this breeder's page
    Then I should not see "Breeder was successfully updated." on breeder's page
    And I should see "HappyPets" on breeder's page
    When I visit this breeder's page: "HappyPets"
    And I should see "$$$" on animal's page

  Scenario: deleting breeder
    Given I am on the login page
    Then I should see "Log In" on breeder's page
    When I fill in "User Name" with "test_1" on the breeder's page
    When I fill in "Password" with "test" on the breeder's page
    And I click the button of "Log In" on this breeder's page
    Then I should see "Logged in!" on breeder's page
    Given I am on the breeder details page of "HappyPets"
    When I click the link of "Delete" on this breeder's page
    Then I should see "Breeder was successfully destroyed." on breeder's page
    And I should not see "HappyPets" on animal's page

  Scenario: adding a new breeder
    Given I am on the login page
    Then I should see "Log In" on breeder's page
    When I fill in "User Name" with "test_4" on the breeder's page
    When I fill in "Password" with "test" on the breeder's page
    And I click the button of "Log In" on this breeder's page
    Then I should see "Logged in!" on breeder's page
    Given I am on the breeders page
    When I click the link of "My Profile" on this breeder's page
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

