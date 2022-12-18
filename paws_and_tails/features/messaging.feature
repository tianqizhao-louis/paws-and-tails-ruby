Feature: user messaging system

  Background: init accounts for testing
    Given I have breeders and petfinders


  @javascript
  Scenario: petfinder messages breeder
    Given I am on the login page
    Then I should see "Log In" on animal's page
    And I fill in "User Name" with "normal_user" on the animal's page
    And I fill in "Password" with "user" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the breeder details page of "Northwestern Wildcats"
    Then I should see "Message Breeder" on breeder's page
    And I click the link of "Message Breeder" on this breeder's page
    Then I should see "Private Message with breeder_test" on breeder's page
    When I type the message "Hi!"
    And I click the button of "Send" on this breeder's page
    Then I should see "You" on breeder's page
    Then I should see "Hi" on breeder's page
    Then I should see "You" appears before "Hi" on the animals page
    And I click the link of "Message Inbox" on this breeder's page
    Then I should see "Message Inbox" on breeder's page
    Then I should see "Conversation with breeder_test" on breeder's page

  @javascript
  Scenario: petfinder shouldn't message breeder who doesn't associate with an user account
    Given I am on the login page
    Then I should see "Log In" on animal's page
    And I fill in "User Name" with "normal_user" on the animal's page
    And I fill in "Password" with "user" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the breeder details page of "Not Associated With User"
    Then I should see "Message Breeder" on breeder's page
    And I click the link of "Message Breeder" on this breeder's page
    Then I should see "Failed to retrieve messages" on breeder's page
    Then I should see "This breeder isn't associated with an active user account." on breeder's page

  @javascript
  Scenario: breeder read messages
    Given I am on the login page
    Then I should see "Log In" on animal's page
    And I fill in "User Name" with "normal_user" on the animal's page
    And I fill in "Password" with "user" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Logged in!" on animal's page
    Given I am on the breeder details page of "Northwestern Wildcats"
    Then I should see "Message Breeder" on breeder's page
    And I click the link of "Message Breeder" on this breeder's page
    Then I should see "Private Message with breeder_test" on breeder's page
    When I type the message "Hi!"
    And I click the button of "Send" on this breeder's page
    Then I should see "You" on breeder's page
    Then I should see "Hi" on breeder's page
    Then I should see "You" appears before "Hi" on the animals page
    And I click the link of "Message Inbox" on this breeder's page
    Then I should see "Message Inbox" on breeder's page
    Then I should see "Conversation with breeder_test" on breeder's page
    And I click the link of "Log Out" on this animal's page
    Given I am on the login page
    Then I should see "Log In" on animal's page
    And I fill in "User Name" with "breeder_test" on the animal's page
    And I fill in "Password" with "breeder" on the animal's page
    And I click the button of "Log In" on this animal's page
    Then I should see "Message Inbox" on breeder's page
    And I click the link of "Message Inbox" on this breeder's page
    Then I should see "Conversation with normal_user" on breeder's page
    And I click the link of "Read" on this breeder's page
    Then I should see "Private Message with normal_user" on breeder's page
    Then I should see "normal_user" on breeder's page
    Then I should see "Hi" on breeder's page
    Then I should see "normal_user" appears before "Hi" on the animals page