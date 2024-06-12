defmodule WorkingWithOtp.Task.NotificationSender do
  @moduledoc """
  This module demonstrates concurrent task execution in Elixir using the `Task` module.

  The `send_notifications/0` function sends email notifications concurrently to a list of predefined email addresses.
  Each email is sent in its own separate process, showcasing Elixir's concurrency capabilities.

  ## Example Usage

      iex> WorkingWithOtp.Task.NotificationSender.send_notifications()
      :ok
      # Logs will show email sending tasks running concurrently with different PIDs
  """
  require Logger

  @emails ["fred@facebook.com", "rebeca@ford.com", "markus@fiat.com"]

  def send_notifications() do
    Enum.each(@emails, fn email ->
      Task.start(fn ->
        send_email(email)
      end)
    end)
  end

  defp send_email(email) do
    Logger.info("Email to #{email} sent | #{inspect(self())}")
  end
end
