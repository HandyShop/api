Feature: Create a product
  In order to sell a new product
  As a manager of a market
  I want to add the product to my market’s product list

  Background:
    Given I am on the product creation page

  Scenario: Create a valid product
    When I create a product with the name “Milk”
    And set quantity to “17”
    And set price to “1.87”
    And set description to “Milk box”
    And set barcode to “123456789”
    Then a valid product should be created

  Scenario: Product description is optional
    When I create a product with the name “Leite Ninho”
    And set quantity to “10”
    And set price to “10.00”
    And set description to “”
    And set barcode to “123456789”
    Then a valid product should be created

  Scenario: Product barcode is optional
    When I create a product with the name “Milk”
    And set quantity to “10”
    And set price to “10.00”
    And set description to “Milk box”
    And set barcode to “”
    Then a valid product should be created

  Scenario: Product barcode is unique
    Given that there is a product named “Milk” with a barcode of “11111111”
    When I create a product with the name “Soy Milk”
    And set quantity to “10”
    And set price to “10.00”
    And set description to “Soy Milk box”
    And set barcode to “11111111”
    Then the product with name “Soy Milk” shouldn’t be created
    And I should be warned that that barcode is already in use

  Scenario: Product name is required
    When I create a product with the name “”
    And set quantity to “10”
    And set price to “10.00”
    And set description to “Milk box”
    And set barcode to “123456789”
    Then the product should not be created

  Scenario: Product quantity is required
    When I create a product with the name “Milk”
    And set quantity to “”
    And set price to “10.00”
    And set description to “Milk box”
    And set barcode to “123456789”
    Then the product should not be created

  Scenario: Product price is required
    When I create a product with the name “Milk”
    And set quantity to “10”
    And set price to “”
    And set description to “Milk box”
    And set barcode to “123456789”
    Then the product should not be created
