defmodule WorkingWithOtp.GenServer.PeriodicWorker do
  @moduledoc """
  A GenServer-based periodic worker that manages and updates transaction counters.

  This module implements a worker that periodically checks and updates
  transaction counts (successful and failed). It provides functionality to:
  - Start the worker with an initial state
  - Update the state with new transaction counts
  - Retrieve the current state
  - Automatically update transaction counts at regular intervals

  The worker uses a 5-second timer to perform periodic updates and simulates
  checking finished transactions with random number generation.
  """

  use GenServer

  require Logger

  @timer 5000

  # Client | Public API functions
  def start_link(opts \\ []) do
    inital_state = %{success_txs: 0, failed_txs: 0}
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, inital_state, opts)
  end

  def update_state(success_txs, failed_txs) do
    GenServer.cast(__MODULE__, {:update_state, {success_txs, failed_txs}})
  end

  def get_state() do
    GenServer.call(__MODULE__, :get_state)
  end

  # Server | Internal callbacks functions
  def init(state) do
    Logger.info("Setting to check for transactions every #{@timer} ms...")
    Process.send_after(self(), :update_transactions_counter, @timer)
    {:ok, state}
  end

  def handle_info(:update_transactions_counter, state) do
    Logger.info("Checking transactions...")
    {new_success_txs, new_failed_txs} = get_finised_transactions()

    new_state = %{
      state
      | success_txs: state.success_txs + new_success_txs,
        failed_txs: state.failed_txs + new_failed_txs
    }

    Process.send_after(self(), :update_transactions_counter, @timer)
    {:noreply, new_state}
  end

  def handle_cast({:update_state, {success_txs, failed_txs}}, _state) do
    new_state = %{success_txs: success_txs, failed_txs: failed_txs}
    {:noreply, new_state}
  end

  def handle_call(:get_state, _from_pid, state) do
    {:reply, state, state}
  end

  defp get_finised_transactions() do
    {:rand.uniform(1000), :rand.uniform(10)}
  end
end
