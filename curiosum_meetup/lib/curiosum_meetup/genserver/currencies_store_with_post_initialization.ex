defmodule CuriosumMeetup.GenServer.CurrenciesStoreWithPostInitialization do
  @moduledoc false

  use GenServer

  require Logger

  @default_name CuriosumMeetup.GenServer.CurrenciesStoreWithPostInitialization

  #API public functions
  def start_link(opts \\ []) do
    inital_state = []
    opts = Keyword.put_new(opts, :name, @default_name)
    GenServer.start_link(@default_name, inital_state, opts)
  end

  def init(state) do
    {:ok, state, {:continue, :make_api_call}}
  end

  def add_element(name \\ @default_name, message) do
    GenServer.cast(name, {:add_element, message})
  end

  def get_elements(name \\ @default_name) do
    GenServer.call(name, :get_elements)
  end

  #Server
  def handle_cast({:add_element, message}, state) do
    state = [message | state]
    {:noreply, state}
  end

  def handle_call(:get_elements, _from_pid, state) do
    {:reply, state, state}
  end

  def handle_continue(:make_api_call, state) do
    Logger.info("handle_continue make_api_call")
    {:noreply, state}
  end

  def heavy_operation do
    Logger.info("Doing heavy operation")
    Process.sleep(4_000)
    ["UYU", "ARS", "USD"]
  end

end
