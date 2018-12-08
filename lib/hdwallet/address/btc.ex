defmodule Hdwallet.Address.BTC do
  @moduledoc """
  Documentation for Hdwallet address BTC.
  """

  @version_bytes %{
    main: <<0x00>>,
    test: <<0x6F>>
  }

  alias Hdwallet.Address.Utils

  @doc """

  """
  def get_address_from_private_hex(private_hex) do
    private_hex
    |> Utils.uncompressed_public_from_private_hex()
    |> Utils.pubkey_hash160()
    |> prepend_version_byte()
    |> encode_base58()
  end

  @doc false
  defp prepend_version_byte(public_hash, network \\ :main) do
    @version_bytes
    |> Map.get(network)
    |> Kernel.<>(public_hash)
  end

  @doc false
  defp encode_base58(data) do
    data = insert_checksum(data)

    data
    |> Hdkey.encode_hex()
    |> String.to_integer(16)
    |> Hdkey.Base58.encode()
    |> prepend_zeros(data)
  end

  @doc false
  defp insert_checksum(data) do
    <<checksum::bytes-size(4), _::bits>> =
      data
      |> Utils.sha256()
      |> Utils.sha256()

    data <> checksum
  end

  defp prepend_zeros(acc, input) do
    input
    |> :binary.bin_to_list()
    |> Enum.find_index(&(&1 != 0))
    |> duplicate_zeros()
    |> Kernel.<>(acc)
  end

  defp duplicate_zeros(count) do
    String.duplicate("1", count)
  end

  # __end_of_module__
end
