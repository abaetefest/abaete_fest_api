defmodule AbaeteFestApi.ServicesTest do
  use AbaeteFestApi.DataCase

  alias AbaeteFestApi.Services

  describe "categories" do
    alias AbaeteFestApi.Services.Category

    import AbaeteFestApi.ServicesFixtures

    @invalid_attrs %{name: nil, type: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Services.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Services.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{name: "some name", type: :services}

      assert {:ok, %Category{} = category} = Services.create_category(valid_attrs)
      assert category.name == "some name"
      assert category.type == :services
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "some updated name", type: :locations}

      assert {:ok, %Category{} = category} = Services.update_category(category, update_attrs)
      assert category.name == "some updated name"
      assert category.type == :locations
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_category(category, @invalid_attrs)
      assert category == Services.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Services.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Services.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Services.change_category(category)
    end
  end

  describe "services" do
    alias AbaeteFestApi.Services.Service

    import AbaeteFestApi.ServicesFixtures

    @invalid_attrs %{address: nil, description: nil, phone: nil, title: nil}

    test "list_services/0 returns all services" do
      service = service_fixture()
      assert Services.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = service_fixture()
      assert Services.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      valid_attrs = %{
        address: "some address",
        description: "some description",
        phone: "some phone",
        title: "some title"
      }

      assert {:ok, %Service{} = service} = Services.create_service(valid_attrs)
      assert service.address == "some address"
      assert service.description == "some description"
      assert service.phone == "some phone"
      assert service.title == "some title"
    end

    test "create_service/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Services.create_service(@invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = service_fixture()

      update_attrs = %{
        address: "some updated address",
        description: "some updated description",
        phone: "some updated phone",
        title: "some updated title"
      }

      assert {:ok, %Service{} = service} = Services.update_service(service, update_attrs)
      assert service.address == "some updated address"
      assert service.description == "some updated description"
      assert service.phone == "some updated phone"
      assert service.title == "some updated title"
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = service_fixture()
      assert {:error, %Ecto.Changeset{}} = Services.update_service(service, @invalid_attrs)
      assert service == Services.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = service_fixture()
      assert {:ok, %Service{}} = Services.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = service_fixture()
      assert %Ecto.Changeset{} = Services.change_service(service)
    end
  end
end
