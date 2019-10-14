defmodule CashlessRemitterWeb.MerchantView do
  use CashlessRemitterWeb, :view
  alias CashlessRemitterWeb.MerchantView

  def render("index.json", %{merchants: merchants}) do
    %{data: render_many(merchants, MerchantView, "merchant.json")}
  end

  def render("show.json", %{merchant: merchant}) do
    %{data: render_one(merchant, MerchantView, "merchant.json")}
  end

  def render("merchant.json", %{merchant: merchant}) do
    %{id: merchant.id,
      name: merchant.name,
      logo: merchant.logo,
      description: merchant.description,
      phone: merchant.phone,
      opening: merchant.opening,
      closing: merchant.closing}
  end
end
