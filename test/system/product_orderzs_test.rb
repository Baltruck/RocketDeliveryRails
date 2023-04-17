require "application_system_test_case"

class ProductOrderzsTest < ApplicationSystemTestCase
  setup do
    @product_orderz = product_orderzs(:one)
  end

  test "visiting the index" do
    visit product_orderzs_url
    assert_selector "h1", text: "Product orderzs"
  end

  test "should create product orderz" do
    visit product_orderzs_url
    click_on "New product orderz"

    fill_in "Product quantity", with: @product_orderz.product_quantity
    fill_in "Product unit cost", with: @product_orderz.product_unit_cost
    click_on "Create Product orderz"

    assert_text "Product orderz was successfully created"
    click_on "Back"
  end

  test "should update Product orderz" do
    visit product_orderz_url(@product_orderz)
    click_on "Edit this product orderz", match: :first

    fill_in "Product quantity", with: @product_orderz.product_quantity
    fill_in "Product unit cost", with: @product_orderz.product_unit_cost
    click_on "Update Product orderz"

    assert_text "Product orderz was successfully updated"
    click_on "Back"
  end

  test "should destroy Product orderz" do
    visit product_orderz_url(@product_orderz)
    click_on "Destroy this product orderz", match: :first

    assert_text "Product orderz was successfully destroyed"
  end
end
