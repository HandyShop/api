Feature: List products of a market
  In order to supervise the market’s current inventory
  As a manager of a market
  I want see all the products in my market

  Scenario: A single product should be shown with edit and remove options
    Given that there is a product named “Milk”
    When I go to the product list for the market “Vendinha”
    Then I should see a single product listed
    And I should see the option to remove it
    And I should see the option to edit it

  Scenario: Products can be filtered by name
    Given that there is a product named “Milk”
    And a product named “Cookie”
    When I type “Mi” in the search field
    Then I should see a single product listed named “Milk”

  Scenario: Products can be filtered by quantity
    Given that there is a product named “Milk” with a quantity of 10
    And a product named “Cookie” with a quantity of 5
    When I select the range 0 to 5 on the quantity search
    Then I should see a single product listed named “Cookie”

  Scenario: Products can be filtered by description
    Given that there is a product named “Milk” with a description of “Milk box”
    And a product named “Cookie” with a description of “Cookies for your monster”
    When I type “monster” in the search field
    Then I should see a single product listed named “Cookie”

  Scenario: Products can be filtered by barcode
    Given that there is a product named “Milk” with a barcode of “159159”
    And a product named “Cookie” with a barcode of “258258”
    When I type “258258” in the barcode search field
    Then I should see a single product listed named “Cookie”

  Scenario: Removed products should be visible to the manager
    Given that there is a product named “Milk” with a barcode of “159159”
    And a product named “Cookie” with a barcode of “258258” that has been removed
    And I am a market manager
    When I search for “258258” in the barcode search field
    And enable the filter by removed products
    Then I should see a single product listed named “Cookie”

