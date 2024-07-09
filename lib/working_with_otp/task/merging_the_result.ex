defmodule WorkingWithOtp.Task.MergingTheResult do
  @moduledoc """
  This module handles fetching currency data from various sources concurrently, merges the results, and saves the response in cache.
  It demonstrates the use of asynchronous tasks to retrieve data from different sources and process this data efficiently, speeding up multiple
  long synchronous functions by 3x.
  """
  require Logger

  alias WorkingWithOtp.Cache.CacheManager

  def fetch_currencies() do
    tasks = [
      fn -> get_currencies_from_database() end,
      fn -> get_currencies_reading_file_on_disk() end,
      fn -> get_currencies_from_external_api_call() end
    ]

    tasks
    |> Task.async_stream(fn task -> task.() end)
    |> Enum.to_list()
    |> merge_currencies()
    |> store_currencies_in_cache()
  end

  def fetch_currencies_with_bad_design() do
    currencies_1 = get_currencies_from_database()
    currencies_2 = get_currencies_reading_file_on_disk()
    currencies_3 = get_currencies_from_external_api_call()

    (currencies_1 ++ currencies_2 ++ currencies_3)
    |> store_currencies_in_cache()
  end

  defp merge_currencies(currencies_lists) do
    Logger.info("Merging currencies")
    List.flatten(currencies_lists)
  end

  defp get_currencies_from_database() do
    Logger.info("Fetching currencies from database | #{inspect(self())}")
    Process.sleep(3_000)
    ["USD", "EUR", "CAD"]
  end

  defp get_currencies_reading_file_on_disk() do
    Logger.info("Fetching currencies from disk | #{inspect(self())}")
    Process.sleep(3_000)
    ["UYU", "ARS", "BRL"]
  end

  defp get_currencies_from_external_api_call() do
    Logger.info("Fetching currencies from external API call | #{inspect(self())}")
    Process.sleep(3_000)
    ["NZD", "BRL", "JPY"]
  end

  defp store_currencies_in_cache(currencies) do
    CacheManager.insert_entry("currencies", currencies)
  end
end
