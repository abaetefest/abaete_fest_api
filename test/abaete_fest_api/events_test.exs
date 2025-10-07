defmodule AbaeteFestApi.EventsTest do
  use AbaeteFestApi.DataCase

  alias AbaeteFestApi.Events

  describe "events" do
    alias AbaeteFestApi.Events.Event

    import AbaeteFestApi.EventsFixtures

    @invalid_attrs %{description: nil, image_url: nil, name: nil, category: nil, recurring: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        category: :sports,
        recurring: false
      }

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.description == "some description"
      assert event.image_url == "some image_url"
      assert event.name == "some name"
      assert event.category == :sports
      assert event.recurring == false
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()

      update_attrs = %{
        description: "some updated description",
        image_url: "some updated image_url",
        name: "some updated name",
        category: :cultural,
        recurring: true
      }

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.description == "some updated description"
      assert event.image_url == "some updated image_url"
      assert event.name == "some updated name"
      assert event.category == :cultural
      assert event.recurring == true
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
