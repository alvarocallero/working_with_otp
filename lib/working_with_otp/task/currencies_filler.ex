defmodule WorkingWithOtp.Task.CurrenciesFiller do
  @moduledoc """
  This module is responsible for fetching a list of currency codes from a database (simulated) and storing them in a cache using ConCache.
  It uses the `Task` module to run asynchronously and logs its operations.
  The goal of this Task is to be executed at the application startup or manually to backfill the currencies in a cache.
  """

  use Task

  require Logger

  alias WorkingWithOtp.Cache.CacheManager

  def start_link(args \\ []) do
    Task.start_link(__MODULE__, :run, args)
  end

  def run() do
    currencies_lst = get_currencies_from_database()
    CacheManager.insert_entry("currencies", currencies_lst)
  end

  defp get_currencies_from_database() do
    Logger.info("Getting currencies from database...")
    ["UYU", "USD", "CAD"]
  end
end
