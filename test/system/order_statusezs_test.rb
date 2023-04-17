require "application_system_test_case"

class OrderStatusezsTest < ApplicationSystemTestCase
  setup do
    @order_statusez = order_statusezs(:one)
  end

  test "visiting the index" do
    visit order_statusezs_url
    assert_selector "h1", text: "Order statusezs"
  end

  test "should create order statusez" do
    visit order_statusezs_url
    click_on "New order statusez"

    fill_in "Name", with: @order_statusez.name
    click_on "Create Order statusez"

    assert_text "Order statusez was successfully created"
    click_on "Back"
  end

  test "should update Order statusez" do
    visit order_statusez_url(@order_statusez)
    click_on "Edit this order statusez", match: :first

    fill_in "Name", with: @order_statusez.name
    click_on "Update Order statusez"

    assert_text "Order statusez was successfully updated"
    click_on "Back"
  end

  test "should destroy Order statusez" do
    visit order_statusez_url(@order_statusez)
    click_on "Destroy this order statusez", match: :first

    assert_text "Order statusez was successfully destroyed"
  end
end
