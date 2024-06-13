defmodule WorkingWithOtp.Task.MergingTheResult do
  @moduledoc """
  This module handles fetching currency data from various sources concurrently, merges the results, and stores them in an Agent.
  It demonstrates the use of asynchronous tasks to retrieve data from different sources, and processes this data efficiently, speeding up multiple
  long synchronous functions by 3x.
  """
  require Logger

  alias WorkingWithOtp.Agent.CurrenciesStore

  def fetch_currencies() do
    tasks = [
      Task.async(fn -> get_currencies_from_database() end),
      Task.async(fn -> get_currencies_reading_file_on_disk() end),
      Task.async(fn -> get_currencies_from_external_api_call() end)
    ]

    tasks
    |> Task.await_many()
    |> merge_currencies()
    |> store_currencies_in_agent()
  end

  def fetch_currencies_with_bad_design() do
    currencies_1 = get_currencies_from_database()
    currencies_2 = get_currencies_reading_file_on_disk()
    currencies_3 = get_currencies_from_external_api_call()

    (currencies_1 ++ currencies_2 ++ currencies_3)
    |> store_currencies_in_agent()
  end

  defp merge_currencies(currencies_lists) do
    Logger.info("Merging currencies")
    List.flatten(currencies_lists)
  end

  defp get_currencies_from_database() do
    Logger.info("Fetching currencies from database")
    Process.sleep(3_000)
    ["USD", "EUR", "CAD"]
  end

  defp get_currencies_reading_file_on_disk() do
    Logger.info("Fetching currencies from disk")
    Process.sleep(3_000)
    ["UYU", "ARS", "BRL"]
  end

  defp get_currencies_from_external_api_call() do
    Logger.info("Fetching currencies from external API call")
    Process.sleep(3_000)
    ["NZD", "BRL", "JPY"]
  end

  defp store_currencies_in_agent(currencies) do
    Logger.info("Storing currencies in Agent")
    Enum.each(currencies, &CurrenciesStore.add_element/1)
  end
end
