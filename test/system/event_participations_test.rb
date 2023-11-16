require "application_system_test_case"

class EventParticipationsTest < ApplicationSystemTestCase
  setup do
    @event_participation = event_participations(:one)
  end

  test "visiting the index" do
    visit event_participations_url
    assert_selector "h1", text: "Event participations"
  end

  test "should create event participation" do
    visit event_participations_url
    click_on "New event participation"

    fill_in "Badge count", with: @event_participation.badge_count
    fill_in "Event", with: @event_participation.event_id
    fill_in "User", with: @event_participation.user_id
    click_on "Create Event participation"

    assert_text "Event participation was successfully created"
    click_on "Back"
  end

  test "should update Event participation" do
    visit event_participation_url(@event_participation)
    click_on "Edit this event participation", match: :first

    fill_in "Badge count", with: @event_participation.badge_count
    fill_in "Event", with: @event_participation.event_id
    fill_in "User", with: @event_participation.user_id
    click_on "Update Event participation"

    assert_text "Event participation was successfully updated"
    click_on "Back"
  end

  test "should destroy Event participation" do
    visit event_participation_url(@event_participation)
    click_on "Destroy this event participation", match: :first

    assert_text "Event participation was successfully destroyed"
  end
end
