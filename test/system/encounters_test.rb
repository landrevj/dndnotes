require "application_system_test_case"

class EncountersTest < ApplicationSystemTestCase
  setup do
    @encounter = encounters(:one)
  end

  test "visiting the index" do
    visit encounters_url
    assert_selector "h1", text: "Encounters"
  end

  test "creating a Encounter" do
    visit encounters_url
    click_on "New Encounter"

    fill_in "Content", with: @encounter.content
    fill_in "Description", with: @encounter.description
    fill_in "Name", with: @encounter.name
    fill_in "User", with: @encounter.user_id
    click_on "Create Encounter"

    assert_text "Encounter was successfully created"
    click_on "Back"
  end

  test "updating a Encounter" do
    visit encounters_url
    click_on "Edit", match: :first

    fill_in "Content", with: @encounter.content
    fill_in "Description", with: @encounter.description
    fill_in "Name", with: @encounter.name
    fill_in "User", with: @encounter.user_id
    click_on "Update Encounter"

    assert_text "Encounter was successfully updated"
    click_on "Back"
  end

  test "destroying a Encounter" do
    visit encounters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Encounter was successfully destroyed"
  end
end
