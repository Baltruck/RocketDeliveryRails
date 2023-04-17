require "application_system_test_case"

class ProductzsTest < ApplicationSystemTestCase
  setup do
    @productz = productzs(:one)
  end

  test "visiting the index" do
    visit productzs_url
    assert_selector "h1", text: "Productzs"
  end

  test "should create productz" do
    visit productzs_url
    click_on "New productz"

    fill_in "Cost", with: @productz.cost
    fill_in "Description", with: @productz.description
    fill_in "Name", with: @productz.name
    click_on "Create Productz"

    assert_text "Productz was successfully created"
    click_on "Back"
  end

  test "should update Productz" do
    visit productz_url(@productz)
    click_on "Edit this productz", match: :first

    fill_in "Cost", with: @productz.cost
    fill_in "Description", with: @productz.description
    fill_in "Name", with: @productz.name
    click_on "Update Productz"

    assert_text "Productz was successfully updated"
    click_on "Back"
  end

  test "should destroy Productz" do
    visit productz_url(@productz)
    click_on "Destroy this productz", match: :first

    assert_text "Productz was successfully destroyed"
  end
end
