defmodule CashlessRemitterWeb.UserControllerTest do
  use CashlessRemitterWeb.ConnCase

  alias CashlessRemitter.Account
  alias CashlessRemitter.Account.User

  @create_attrs %{
    email: "user@test.com",
    name: "some name",
    order_count: 42,
    phone_number: "+256752235498",
    pin: 0000
  }
  @update_attrs %{
    email: "user2@test.com",
    name: "some updated name",
    order_count: 43,
    phone_number: "+254724778017",
    pin: 1111
  }
  @invalid_attrs %{email: nil, name: nil, order_count: nil, phone_number: nil, pin: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "email" => "user@test.com",
               "name" => "some name",
               "order_count" => 42,
               "phone_number" => "+256752235498",
               "pin" => 0000
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "email" => "user2@test.com",
               "name" => "some updated name",
               "order_count" => 43,
               "phone_number" => "+254724778017",
               "pin" => 1111
             }
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, user_path(conn, :show, user))
      end)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
