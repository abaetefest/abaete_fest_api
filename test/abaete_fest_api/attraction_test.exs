defmodule AbaeteFestApi.AttractionTest do
  use AbaeteFestApi.DataCase

  alias AbaeteFestApi.Attraction

  describe "attractions" do
    alias AbaeteFestApi.Attraction.Attractions

    import AbaeteFestApi.AttractionFixtures

    @invalid_attrs %{
      address: nil,
      description: nil,
      image_url: nil,
      latitude: nil,
      longitude: nil,
      name: nil
    }

    test "list_attractions/0 returns all attractions" do
      attractions = attractions_fixture()
      assert Attraction.list_attractions() == [attractions]
    end

    test "get_attractions!/1 returns the attractions with given id" do
      attractions = attractions_fixture()
      assert Attraction.get_attractions!(attractions.id) == attractions
    end

    test "create_attractions/1 with valid data creates a attractions" do
      valid_attrs = %{
        address: "some address",
        description: "some description",
        image_url: "some image_url",
        latitude: "some latitude",
        longitude: "some longitude",
        name: "some name"
      }

      assert {:ok, %Attractions{} = attractions} = Attraction.create_attractions(valid_attrs)
      assert attractions.address == "some address"
      assert attractions.description == "some description"
      assert attractions.image_url == "some image_url"
      assert attractions.latitude == "some latitude"
      assert attractions.longitude == "some longitude"
      assert attractions.name == "some name"
    end

    test "create_attractions/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attraction.create_attractions(@invalid_attrs)
    end

    test "update_attractions/2 with valid data updates the attractions" do
      attractions = attractions_fixture()

      update_attrs = %{
        address: "some updated address",
        description: "some updated description",
        image_url: "some updated image_url",
        latitude: "some updated latitude",
        longitude: "some updated longitude",
        name: "some updated name"
      }

      assert {:ok, %Attractions{} = attractions} =
               Attraction.update_attractions(attractions, update_attrs)

      assert attractions.address == "some updated address"
      assert attractions.description == "some updated description"
      assert attractions.image_url == "some updated image_url"
      assert attractions.latitude == "some updated latitude"
      assert attractions.longitude == "some updated longitude"
      assert attractions.name == "some updated name"
    end

    test "update_attractions/2 with invalid data returns error changeset" do
      attractions = attractions_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Attraction.update_attractions(attractions, @invalid_attrs)

      assert attractions == Attraction.get_attractions!(attractions.id)
    end

    test "delete_attractions/1 deletes the attractions" do
      attractions = attractions_fixture()
      assert {:ok, %Attractions{}} = Attraction.delete_attractions(attractions)
      assert_raise Ecto.NoResultsError, fn -> Attraction.get_attractions!(attractions.id) end
    end

    test "change_attractions/1 returns a attractions changeset" do
      attractions = attractions_fixture()
      assert %Ecto.Changeset{} = Attraction.change_attractions(attractions)
    end
  end
end
