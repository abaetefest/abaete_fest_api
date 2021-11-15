defmodule AbaeteFestApiWeb.AttractionsControllerTest do
  use AbaeteFestApiWeb.ConnCase

  import AbaeteFestApi.AttractionFixtures

  alias AbaeteFestApi.Attraction.Attractions

  @create_attrs %{
    address: "some address",
    description: "some description",
    image_url: "some image_url",
    latitude: "some latitude",
    longitude: "some longitude",
    name: "some name"
  }
  @update_attrs %{
    address: "some updated address",
    description: "some updated description",
    image_url: "some updated image_url",
    latitude: "some updated latitude",
    longitude: "some updated longitude",
    name: "some updated name"
  }
  @invalid_attrs %{
    address: nil,
    description: nil,
    image_url: nil,
    latitude: nil,
    longitude: nil,
    name: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all attractions", %{conn: conn} do
      conn = get(conn, Routes.attractions_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create attractions" do
    test "renders attractions when data is valid", %{conn: conn} do
      conn = post(conn, Routes.attractions_path(conn, :create), attractions: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.attractions_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some address",
               "description" => "some description",
               "image_url" => "some image_url",
               "latitude" => "some latitude",
               "longitude" => "some longitude",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.attractions_path(conn, :create), attractions: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update attractions" do
    setup [:create_attractions]

    test "renders attractions when data is valid", %{
      conn: conn,
      attractions: %Attractions{id: id} = attractions
    } do
      conn =
        put(conn, Routes.attractions_path(conn, :update, attractions), attractions: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.attractions_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "description" => "some updated description",
               "image_url" => "some updated image_url",
               "latitude" => "some updated latitude",
               "longitude" => "some updated longitude",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, attractions: attractions} do
      conn =
        put(conn, Routes.attractions_path(conn, :update, attractions), attractions: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete attractions" do
    setup [:create_attractions]

    test "deletes chosen attractions", %{conn: conn, attractions: attractions} do
      conn = delete(conn, Routes.attractions_path(conn, :delete, attractions))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.attractions_path(conn, :show, attractions))
      end
    end
  end

  defp create_attractions(_) do
    attractions = attractions_fixture()
    %{attractions: attractions}
  end
end
