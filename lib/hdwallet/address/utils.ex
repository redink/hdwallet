defmodule Hdwallet.Address.Utils do
  @moduledoc """
  Documentation for Hdwallet address utils.
  """

  @doc """

  """
  def uncompressed_public_from_private_hex(private_hex) do
    private_hex
    |> Hdkey.decode_hex()
    |> get_public_key()
  end

  @doc false
  defp get_public_key(<<private_key::binary-size(32)>>) do
    {:ok, public_key} = :libsecp256k1.ec_pubkey_create(private_key, :uncompressed)
    public_key
  end

  @doc """

  """
  def pubkey_hash160(public_key) do
    public_key
    |> sha256()
    |> ripemd160()
  end

  @doc """

  """
  def sha256(data) do
    :crypto.hash(:sha256, data)
  end

  @doc """

  """
  def ripemd160(data) do
    :crypto.hash(:ripemd160, data)
  end

  # __end_of_module__
end
