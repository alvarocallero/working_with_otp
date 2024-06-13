defmodule WorkingWithOtp.GenServer.CurrenciesStore do
  @moduledoc """
  A GenServer module for storing the currencies supported by the app.
  This module provides functions to start the GenServer, add a currency, and retrieve all the currencies from the state.
  It demonstrates basic GenServer functionality, including asynchronous casting and synchronous calling.
  """

  use GenServer

  require Logger

  # API public functions
  def start_link(opts \\ []) do
    inital_state = []
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, inital_state, opts)
  end

  def init(state) do
    {:ok, state}
  end

  def add_element(message) do
    GenServer.cast(__MODULE__, {:add_element, message})
  end

  def get_elements() do
    GenServer.call(__MODULE__, :get_elements)
  end

  # Server
  def handle_cast({:add_element, _message}, _state) do
    state = heavy_operation()
    {:noreply, state}
  end

  def handle_call(:get_elements, _from_pid, state) do
    {:reply, state, state}
  end

  def heavy_operation do
    Process.sleep(4_000)
    ["UYU", "ARS", "USD"]
  end
end
