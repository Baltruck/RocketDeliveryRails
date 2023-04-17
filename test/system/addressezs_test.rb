require "application_system_test_case"

class AddressezsTest < ApplicationSystemTestCase
  setup do
    @addressez = addressezs(:one)
  end

  test "visiting the index" do
    visit addressezs_url
    assert_selector "h1", text: "Addressezs"
  end

  test "should create addressez" do
    visit addressezs_url
    click_on "New addressez"

    fill_in "City", with: @addressez.city
    fill_in "Postal code", with: @addressez.postal_code
    fill_in "Street address", with: @addressez.street_address
    click_on "Create Addressez"

    assert_text "Addressez was successfully created"
    click_on "Back"
  end

  test "should update Addressez" do
    visit addressez_url(@addressez)
    click_on "Edit this addressez", match: :first

    fill_in "City", with: @addressez.city
    fill_in "Postal code", with: @addressez.postal_code
    fill_in "Street address", with: @addressez.street_address
    click_on "Update Addressez"

    assert_text "Addressez was successfully updated"
    click_on "Back"
  end

  test "should destroy Addressez" do
    visit addressez_url(@addressez)
    click_on "Destroy this addressez", match: :first

    assert_text "Addressez was successfully destroyed"
  end
end
