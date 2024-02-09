defmodule CuriosumMeetup.GenServer.CurrenciesStore do
  @moduledoc false

  use GenServer

  require Logger

  @default_name CuriosumMeetup.GenServer.CurrenciesStore

  #API public functions
  def start_link(opts \\ []) do
    inital_state = []
    opts = Keyword.put_new(opts, :name, @default_name)
    GenServer.start_link(@default_name, inital_state, opts)
  end

  def init(state) do
    {:ok, state}
  end


  def add_element(name \\ @default_name, message) do
    GenServer.cast(name, {:add_element, message})
  end

  def get_elements(name \\ @default_name) do
    GenServer.call(name, :get_elements)
  end

  #Server
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
