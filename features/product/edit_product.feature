Feature: Edit a product
  In order to keep the product information updated
  As a manager of a market
  I want to edit an existing product of my market’s product list

  Background:
    Given I am on the product editing page

  Scenario: Edit product successfully
    Given that there is a product named “Milk”
    And that the quantity of the product is 10
    When I edit that product
    And set quantity to “87”
    And set price to “1.98”
    And set description to “Milk box”
    And set barcode to “999999”
    Then the product should be updated with success

  Scenario: Set product’s quantity to zero
    Given that there is a product named “Milk”
    And that the quantity of the product is 10
    When I edit that product
    And set quantity to “0”
    Then the product should be updated with success

  Scenario: Set product’s price to zero with approval
    Given that there is a product named “Milk”
    And that the price of the product is “1,89”
    When I edit that product
    And set the price to “0,00”
    Then I should be asked for confirmation on a product without price
    And I approve the change
    Then the product price should be “0,00”

  Scenario: Set product’s price to zero with refusal
    Given that there is a product named “Milk”
    And that the price of the product is “1,89”
    When I edit that product
    And set the price to “0,00”
    Then I should be asked for confirmation on a  product without price
    And I refuse the change
    Then  the product price should be “1,89”

  Scenario: Set product’s barcode to an already existing barcode
    Given that there is a product named “Milk” with a barcode of “11111111”
    And that there is a product named “Soy Milk” with a barcode of “21111111”
    When I edit the product named “Milk”
    And set the barcode to “21111111”
    Then the product with name “Milk” shouldn’t be updated
    And I should be warned that the barcode “21111111” is already in use
    And the product named “Milk” should have a barcode of “11111111”

  Scenario: Product’s description should not be empty
    Given that there is a product named “Milk”
    And that the description of the product is “Milk box”
    When I edit that product
    And set description to “”
    Then I should get the error message “Description is required”

