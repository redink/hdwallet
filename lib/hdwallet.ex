defmodule Hdwallet do
  @moduledoc """
  Documentation for Hdwallet.
  """

  alias Hdwallet.Address.ETH, as: ETHAddress
  alias Hdwallet.Address.BTC, as: BTCAddress

  @doc """

  """
  def get_address_from_private_hex(:eth, private_hex) do
    ETHAddress.get_address_from_private_hex(private_hex)
  end

  def get_address_from_private_hex(:btc, private_hex) do
    BTCAddress.get_address_from_private_hex(private_hex)
  end

  # __end_of_module__
end
