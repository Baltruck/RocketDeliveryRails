require "application_system_test_case"

class OrderzsTest < ApplicationSystemTestCase
  setup do
    @orderz = orderzs(:one)
  end

  test "visiting the index" do
    visit orderzs_url
    assert_selector "h1", text: "Orderzs"
  end

  test "should create orderz" do
    visit orderzs_url
    click_on "New orderz"

    fill_in "Restaurant rating", with: @orderz.restaurant_rating
    click_on "Create Orderz"

    assert_text "Orderz was successfully created"
    click_on "Back"
  end

  test "should update Orderz" do
    visit orderz_url(@orderz)
    click_on "Edit this orderz", match: :first

    fill_in "Restaurant rating", with: @orderz.restaurant_rating
    click_on "Update Orderz"

    assert_text "Orderz was successfully updated"
    click_on "Back"
  end

  test "should destroy Orderz" do
    visit orderz_url(@orderz)
    click_on "Destroy this orderz", match: :first

    assert_text "Orderz was successfully destroyed"
  end
end
