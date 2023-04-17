require "application_system_test_case"

class ReztaurantsTest < ApplicationSystemTestCase
  setup do
    @reztaurant = reztaurants(:one)
  end

  test "visiting the index" do
    visit reztaurants_url
    assert_selector "h1", text: "Reztaurants"
  end

  test "should create reztaurant" do
    visit reztaurants_url
    click_on "New reztaurant"

    check "Active" if @reztaurant.active
    fill_in "Email", with: @reztaurant.email
    fill_in "Name", with: @reztaurant.name
    fill_in "Phone", with: @reztaurant.phone
    click_on "Create Reztaurant"

    assert_text "Reztaurant was successfully created"
    click_on "Back"
  end

  test "should update Reztaurant" do
    visit reztaurant_url(@reztaurant)
    click_on "Edit this reztaurant", match: :first

    check "Active" if @reztaurant.active
    fill_in "Email", with: @reztaurant.email
    fill_in "Name", with: @reztaurant.name
    fill_in "Phone", with: @reztaurant.phone
    click_on "Update Reztaurant"

    assert_text "Reztaurant was successfully updated"
    click_on "Back"
  end

  test "should destroy Reztaurant" do
    visit reztaurant_url(@reztaurant)
    click_on "Destroy this reztaurant", match: :first

    assert_text "Reztaurant was successfully destroyed"
  end
end
