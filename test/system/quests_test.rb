require "application_system_test_case"

class QuestsTest < ApplicationSystemTestCase
  setup do
    @quest = quests(:one)
  end

  test "visiting the index" do
    visit quests_url
    assert_selector "h1", text: "Quests"
  end

  test "creating a Quest" do
    visit quests_url
    click_on "New Quest"

    fill_in "Description", with: @quest.description
    fill_in "Name", with: @quest.name
    click_on "Create Quest"

    assert_text "Quest was successfully created"
    click_on "Back"
  end

  test "updating a Quest" do
    visit quests_url
    click_on "Edit", match: :first

    fill_in "Description", with: @quest.description
    fill_in "Name", with: @quest.name
    click_on "Update Quest"

    assert_text "Quest was successfully updated"
    click_on "Back"
  end

  test "destroying a Quest" do
    visit quests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Quest was successfully destroyed"
  end
end
