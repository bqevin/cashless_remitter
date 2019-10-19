defmodule CashlessRemitterWeb.MerchantControllerTest do
  use CashlessRemitterWeb.ConnCase

  alias CashlessRemitter.Vendor
  alias CashlessRemitter.Vendor.Merchant

  @create_attrs %{
    closing_time: ~T[14:00:00.000000],
    description: "some description",
    logo: "http://some.logo",
    name: "some name",
    opening_time: ~T[14:00:00.000000],
    phone: "+256752235498"
  }
  @update_attrs %{
    closing_time: ~T[15:01:01.000000],
    description: "some updated description",
    logo: "http://some.update.logo",
    name: "some updated name",
    opening_time: ~T[15:01:01.000000],
    phone: "+254724778017"
  }
  @invalid_attrs %{
    closing_time: nil,
    description: nil,
    logo: nil,
    name: nil,
    opening_time: nil,
    phone: nil
  }

  def fixture(:merchant) do
    {:ok, merchant} = Vendor.create_merchant(@create_attrs)
    merchant
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all merchants", %{conn: conn} do
      conn = get(conn, merchant_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create merchant" do
    test "renders merchant when data is valid", %{conn: conn} do
      conn = post(conn, merchant_path(conn, :create), merchant: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, merchant_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "closing_time" => ~T[14:00:00.000000],
               "description" => "some description",
               "logo" => "http://some.logo",
               "name" => "some name",
               "opening_time" => ~T[14:00:00.000000],
               "phone" => "+256752235498"
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, merchant_path(conn, :create), merchant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update merchant" do
    setup [:create_merchant]

    test "renders merchant when data is valid", %{
      conn: conn,
      merchant: %Merchant{id: id} = merchant
    } do
      conn = put(conn, merchant_path(conn, :update, merchant), merchant: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, merchant_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "closing_time" => ~T[15:01:01.000000],
               "description" => "some updated description",
               "logo" => "http://some.update.logo",
               "name" => "some updated name",
               "opening_time" => ~T[15:01:01.000000],
               "phone" => "+254724778017"
             }
    end

    test "renders errors when data is invalid", %{conn: conn, merchant: merchant} do
      conn = put(conn, merchant_path(conn, :update, merchant), merchant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete merchant" do
    setup [:create_merchant]

    test "deletes chosen merchant", %{conn: conn, merchant: merchant} do
      conn = delete(conn, merchant_path(conn, :delete, merchant))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, merchant_path(conn, :show, merchant))
      end)
    end
  end

  defp create_merchant(_) do
    merchant = fixture(:merchant)
    {:ok, merchant: merchant}
  end
end
