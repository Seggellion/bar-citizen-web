require "test_helper"

class EventParticipationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_participation = event_participations(:one)
  end

  test "should get index" do
    get event_participations_url
    assert_response :success
  end

  test "should get new" do
    get new_event_participation_url
    assert_response :success
  end

  test "should create event_participation" do
    assert_difference("EventParticipation.count") do
      post event_participations_url, params: { event_participation: { badge_count: @event_participation.badge_count, event_id: @event_participation.event_id, user_id: @event_participation.user_id } }
    end

    assert_redirected_to event_participation_url(EventParticipation.last)
  end

  test "should show event_participation" do
    get event_participation_url(@event_participation)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_participation_url(@event_participation)
    assert_response :success
  end

  test "should update event_participation" do
    patch event_participation_url(@event_participation), params: { event_participation: { badge_count: @event_participation.badge_count, event_id: @event_participation.event_id, user_id: @event_participation.user_id } }
    assert_redirected_to event_participation_url(@event_participation)
  end

  test "should destroy event_participation" do
    assert_difference("EventParticipation.count", -1) do
      delete event_participation_url(@event_participation)
    end

    assert_redirected_to event_participations_url
  end
end
