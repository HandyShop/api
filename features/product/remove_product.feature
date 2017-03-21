Feature: Remove a product
  In order to keep an accurate information of my current inventory
  As a manager of a market
  I want to remove an existing product of my market’s product list

  Background:
    Given I am on the product list page

  Scenario: Remove a product with approval
    Given that there is a product named “Milk”
    When I remove that product
    Then I should be asked for confirmation on it’s removal
    When I give approval
    Then the product shouldn’t be available for purchase

  Scenario: Product should not be removed without approval
    Given that there is a product named “Milk”
    When I remove that product
    Then I should be asked for confirmation on it’s removal
    When I don’t give approval
    Then the product should be available for purchase
