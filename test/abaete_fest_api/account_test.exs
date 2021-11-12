defmodule AbaeteFestApi.AccountTest do
  use AbaeteFestApi.DataCase

  alias AbaeteFestApi.Account

  describe "users" do
    alias AbaeteFestApi.Account.User

    import AbaeteFestApi.AccountFixtures

    @invalid_attrs %{email: nil, is_admin: nil, name: nil, password_hash: nil, phone: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{
        email: "some email",
        is_admin: true,
        name: "some name",
        password_hash: "some password_hash",
        phone: "some phone"
      }

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.email == "some email"
      assert user.is_admin == true
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()

      update_attrs = %{
        email: "some updated email",
        is_admin: false,
        name: "some updated name",
        password_hash: "some updated password_hash",
        phone: "some updated phone"
      }

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.email == "some updated email"
      assert user.is_admin == false
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
