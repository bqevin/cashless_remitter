defmodule CashlessRemitter.AccountTest do
  use CashlessRemitter.DataCase

  alias CashlessRemitter.Account

  describe "users" do
    alias CashlessRemitter.Account.User

    @valid_attrs %{email: "some email", name: "some name", order_count: 42, phone_number: "some phone_number", pin: 42}
    @update_attrs %{email: "some updated email", name: "some updated name", order_count: 43, phone_number: "some updated phone_number", pin: 43}
    @invalid_attrs %{email: nil, name: nil, order_count: nil, phone_number: nil, pin: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.order_count == 42
      assert user.phone_number == "some phone_number"
      assert user.pin == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Account.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.order_count == 43
      assert user.phone_number == "some updated phone_number"
      assert user.pin == 43
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
