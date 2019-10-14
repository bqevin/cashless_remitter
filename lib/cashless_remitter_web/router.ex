defmodule CashlessRemitterWeb.Router do
  use CashlessRemitterWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", CashlessRemitterWeb do
    pipe_through(:api)

    resources("/users", UserController, except: [:new, :edit])
    resources("/merchants", MerchantController, except: [:new, :edit])
  end
end
