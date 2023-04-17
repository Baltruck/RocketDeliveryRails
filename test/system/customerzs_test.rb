require "application_system_test_case"

class CustomerzsTest < ApplicationSystemTestCase
  setup do
    @customerz = customerzs(:one)
  end

  test "visiting the index" do
    visit customerzs_url
    assert_selector "h1", text: "Customers"
  end

  test "should create customer" do
    visit customerzs_url
    click_on "New customer"

    check "Active" if @customerz.active
    fill_in "Email", with: @customerz.email
    fill_in "Phone", with: @customerz.phone
    click_on "Create Customer"

    assert_text "Customer was successfully created"
    click_on "Back"
  end

  test "should update Customer" do
    visit customerz_url(@customerz)
    click_on "Edit this customer", match: :first

    check "Active" if @customerz.active
    fill_in "Email", with: @customerz.email
    fill_in "Phone", with: @customerz.phone
    click_on "Update Customer"

    assert_text "Customer was successfully updated"
    click_on "Back"
  end

  test "should destroy Customerz" do
    visit customerz_url(@customerz)
    click_on "Delete this customer", match: :first

    assert_text "Customer was successfully deleted"
  end
end
