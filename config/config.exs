# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cashless_remitter,
  ecto_repos: [CashlessRemitter.Repo]

# Configures the endpoint
config :cashless_remitter, CashlessRemitterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KddSWHNznrNFqmvHdYmPsIL54wE+p6IGC0Cc2Edze4PFVF9DYTFLaY3KJv13/OZj",
  render_errors: [view: CashlessRemitterWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CashlessRemitter.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
