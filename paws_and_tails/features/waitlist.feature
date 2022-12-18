Feature: petfinder can join animal's waitlist

  Background: animals have been added to the database

    Given the following animals exist:
      | name              | animal_type  | breed            | price | anticipated_birthday | breeder_id |
      | Sleeping Pajamas  | Dog          | Labrador         | 600   | 2022-12-01           | 1          |
      | Hello Kitty       | Cat          | Ragdoll          | 100   | 2023-09-01           | 2          |
      | Parody            | Bird         | Parrot           | 15    | 2022-12-13           | 1          |

    And  I am on the animals page
    Then 3 seed animals should exist


  @javascript
  Scenario: join animal's waitlist
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "normal_user" on the animal's page
    When I fill in "Password" with "user" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Join Animal Liter Waitlist" on animal's page
    When I click the button to join the waitlist
    Then I should see "Your current position:1" on animal's page
    Then I should see "Total Waitlist:1" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Leave Waitlist" on animal's page

  @javascript
  Scenario: leave animal's waitlist
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "normal_user" on the animal's page
    When I fill in "Password" with "user" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Join Animal Liter Waitlist" on animal's page
    When I click the button to join the waitlist
    Then I should see "Your current position:1" on animal's page
    Then I should see "Total Waitlist:1" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Leave Waitlist" on animal's page
    When I click the button to leave the waitlist
    Then I should see "Join Animal Liter Waitlist" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Join Animal Liter Waitlist" on animal's page

  @javascript
  Scenario: breeder managing animal's waitlist
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "normal_user" on the animal's page
    When I fill in "Password" with "user" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Join Animal Liter Waitlist" on animal's page
    When I click the button to join the waitlist
    Then I should see "Your current position:1" on animal's page
    Then I should see "Total Waitlist:1" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Leave Waitlist" on animal's page
    And I click the link of "Log Out" on this animal's page
    Given I am on the login page
    Then I should see "Log In" on animal's page
    When I fill in "User Name" with "test_1" on the animal's page
    When I fill in "Password" with "test" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should see "Breeder Panel" on animal's page
    Then I should see "normal_user" on animal's page
    And I click the link of "Remove from Waitlist" on this animal's page
    Given I am on the animal details page of "Sleeping Pajamas"
    Then I should not see "normal_user" on animal's page