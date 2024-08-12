defmodule WorkingWithOtp.Task.MergingTheResult do
  @moduledoc """
  This module handles fetching currency data from various sources concurrently, merges the results, and saves the response in cache.
  It demonstrates the use of asynchronous tasks to retrieve data from different sources and process this data efficiently, speeding up multiple
  long synchronous functions by 3x.

  This is the output of the logic in the pipes section:
    |> Task.async_stream(fn task -> task.() end) ==> Function<3.112246596/2 in Task.build_stream/3>
    |> Enum.map(fn {:ok, currencies_list} -> currencies_list end) ==> [["USD", "EUR", "CAD"], ["UYU", "ARS", "BRL"], ["NZD", "BRL", "JPY"]]
    |> List.flatten() ==> ["USD", "EUR", "CAD", "UYU", "ARS", "BRL", "NZD", "BRL", "JPY"]
  """
  require Logger

  def fetch_currencies_using_task() do
    tasks = [
      fn -> get_currencies_from_database() end,
      fn -> get_currencies_reading_file_on_disk() end,
      fn -> get_currencies_from_external_api_call() end
    ]

    tasks
    |> Task.async_stream(fn task -> task.() end)
    |> Enum.map(fn {:ok, currencies_list} -> currencies_list end)
    |> List.flatten()
    |> store_currencies_in_cache()
  end

  def fetch_currencies_without_using_task() do
    currencies_1 = get_currencies_from_database()
    currencies_2 = get_currencies_reading_file_on_disk()
    currencies_3 = get_currencies_from_external_api_call()

    (currencies_1 ++ currencies_2 ++ currencies_3)
    |> store_currencies_in_cache()
  end

  defp get_currencies_from_database() do
    Logger.info("Fetching currencies from database | #{inspect(self())}")
    Process.sleep(3_000)
    ["USD", "EUR", "CAD"]
  end

  defp get_currencies_reading_file_on_disk() do
    Logger.info("Fetching currencies from disk | #{inspect(self())}")
    Process.sleep(4_000)
    ["UYU", "ARS", "BRL"]
  end

  defp get_currencies_from_external_api_call() do
    Logger.info("Fetching currencies from external API call | #{inspect(self())}")
    Process.sleep(3_000)
    ["NZD", "BRL", "JPY"]
  end

  defp store_currencies_in_cache(currencies) do
    Logger.info("Storing currencies in cache: #{inspect(currencies)}")
  end
end
