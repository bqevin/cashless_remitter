defmodule CashlessRemitterWeb.MerchantController do
  use CashlessRemitterWeb, :controller

  alias CashlessRemitter.Vendor
  alias CashlessRemitter.Vendor.Merchant

  action_fallback CashlessRemitterWeb.FallbackController

  def index(conn, _params) do
    merchants = Vendor.list_merchants()
    render(conn, "index.json", merchants: merchants)
  end

  def create(conn, %{"merchant" => merchant_params}) do
    with {:ok, %Merchant{} = merchant} <- Vendor.create_merchant(merchant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", merchant_path(conn, :show, merchant))
      |> render("show.json", merchant: merchant)
    end
  end

  def show(conn, %{"id" => id}) do
    merchant = Vendor.get_merchant!(id)
    render(conn, "show.json", merchant: merchant)
  end

  def update(conn, %{"id" => id, "merchant" => merchant_params}) do
    merchant = Vendor.get_merchant!(id)

    with {:ok, %Merchant{} = merchant} <- Vendor.update_merchant(merchant, merchant_params) do
      render(conn, "show.json", merchant: merchant)
    end
  end

  def delete(conn, %{"id" => id}) do
    merchant = Vendor.get_merchant!(id)
    with {:ok, %Merchant{}} <- Vendor.delete_merchant(merchant) do
      send_resp(conn, :no_content, "")
    end
  end
end
