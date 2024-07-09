defmodule WorkingWithOtp.Task.NotificationSender do
  @moduledoc """
  This module demonstrates concurrent task execution in Elixir using the `Task` module.

  The `send_notifications/0` function sends email notifications concurrently to a list of predefined email addresses.
  Each email is sent separately, showcasing Elixir's concurrency capabilities.
  """
  require Logger

  @emails ["fred@facebook.com", "rebeca@ford.com", "markus@fiat.com"]

  def send_notifications() do
    Enum.each(@emails, fn email ->
      Task.Supervisor.start_child(TaskSupervisor, fn ->
        send_email(email)
      end)
    end)
  end

  defp send_email(email) do
    Logger.info("Email to #{email} sent | #{inspect(self())}")
  end
end
