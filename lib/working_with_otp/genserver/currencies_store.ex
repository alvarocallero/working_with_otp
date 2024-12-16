defmodule WorkingWithOtp.GenServer.CurrenciesStore do
  @moduledoc """
  A GenServer module for storing the currencies supported by the app.
  This module provides functions to start the GenServer, add a currency, and retrieve all the currencies from the state.
  It demonstrates basic GenServer functionality, including asynchronous casting and synchronous calling.
  """

  use GenServer

  require Logger

  # Client | Public API functions
  def start_link(_opts) do
    inital_state = []
    GenServer.start_link(__MODULE__, inital_state, name: __MODULE__)
  end

  def add_element(message) do
    GenServer.cast(__MODULE__, {:add_element, message})
  end

  def get_elements() do
    GenServer.call(__MODULE__, :get_elements)
  end

  def save_to_file() do
    GenServer.cast(__MODULE__, :save_to_file)
  end

  # Server | Internal callbacks functions
  def init(state) do
    {:ok, state}
  end

  def handle_cast({:add_element, element}, state) do
    new_state = [element | state]
    {:noreply, new_state}
  end

  def handle_cast(:save_to_file, state) do
    File.write!("currencies_store.txt", Jason.encode!(state))
    Logger.info("State saved to file!")
    {:noreply, state}
  end

  def handle_call(:get_elements, _from_pid, state) do
    {:reply, state, state}
  end


  def heavy_operation() do
    Logger.info("Doing heavy operation...")
    Process.sleep(4_000)
    Logger.info("Heavy operation finished!")
    ["UYU", "USD", "EUR"]
  end
end
