defmodule WorkingWithOtp.GenServer.CurrenciesStoreWithPostInitializationMoreSteps do
  @moduledoc """
  A GenServer module for storing the currencies supported by the app.
  This module provides functions to start the GenServer, add a currency, and retrieve all the currencies from the state.
  It leverages the `handle_continue` callback to perform a series of operations immediately after the server has been initialized,
  ensuring that initialization proceeds in several defined steps.
  """
  use GenServer

  require Logger

  # Client | Public API functions
  def start_link(opts \\ []) do
    inital_state = []
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, inital_state, opts)
  end

  def add_element(message) do
    GenServer.cast(__MODULE__, {:add_element, message})
  end

  def get_elements() do
    GenServer.call(__MODULE__, :get_elements)
  end

  # Server | Internal callbacks functions
  def init(state) do
    {:ok, state, {:continue, :step_number_1}}
  end

  def handle_cast({:add_element, message}, state) do
    state = [message | state]
    {:noreply, state}
  end

  def handle_call(:get_elements, _from_pid, state) do
    {:reply, state, state}
  end

  def handle_continue(:step_number_1, state) do
    Logger.info("handle_continue - executing step_number_1")
    new_state = state ++ ["USD", "EUR", "CAD"]
    {:noreply, new_state, {:continue, :step_number_2}}
  end

  def handle_continue(:step_number_2, state) do
    Logger.info("handle_continue - executing step_number_2")
    new_state = state ++ ["UYU", "ARS", "BRL"]
    heavy_operation()
    {:noreply, new_state, {:continue, :step_number_3}}
  end

  def handle_continue(:step_number_3, state) do
    Logger.info("handle_continue - executing step_number_3")

    final_state = state ++ ["NZD", "BRL", "JPY"]

    {:noreply, final_state}
  end

  def heavy_operation do
    Logger.info("Doing heavy operation...")
    Process.sleep(4_000)
    Logger.info("Heavy operation finished!")
  end
end
