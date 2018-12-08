defmodule Hdwallet.MixProject do
  use Mix.Project

  def project do
    [
      app: :hdwallet,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:libsecp256k1, "~> 0.1.10"},
      {:keccakf1600, "~> 2.0", hex: :keccakf1600_orig},
      {:hdkey, github: "redink/hdkey"}
    ]
  end
end
