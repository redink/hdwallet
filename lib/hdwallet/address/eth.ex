defmodule Hdwallet.Address.ETH do
  @moduledoc """
  Documentation for Hdwallet address ETH.
  """

  alias Hdwallet.Address.Utils

  @doc """

  """
  def get_address_from_private_hex(private_hex) do
    <<4::size(8), key::binary-size(64)>> = Utils.uncompressed_public_from_private_hex(private_hex)
    <<_::binary-size(12), eth_address::binary-size(20)>> = keccak256(key)
    "0x#{Hdkey.encode_hex(eth_address)}"
  end

  def get_address_from_compressed_public_hex(public_hex) do
    <<4::size(8), key::binary-size(64)>> =
      public_hex
      |> Hdkey.decode_hex()
      |> :libsecp256k1.ec_pubkey_decompress()
      |> elem(1)

    <<_::binary-size(12), eth_address::binary-size(20)>> = keccak256(key)
    "0x#{Hdkey.encode_hex(eth_address)}"
  end

  @doc false
  defp keccak256(key) do
    :keccakf1600.hash(:sha3_256, key)
  end

  # __end_of_module__
end
