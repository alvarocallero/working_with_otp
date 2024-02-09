defmodule CuriosumMeetup.Task.ConcurrentCode do

  def send_notifications() do
    emails = ["abel@a.com", "raul@r.com", "peter@p.com"]
    notify_all(emails)
  end

  defp send_email(email) do
    IO.puts("Email to #{email} sent")
    {:ok, "email_sent"}
  end

  defp notify_all(emails) do
    Enum.each(emails, fn email ->
      Task.start(fn ->
        send_email(email)
      end)
    end)
  end

end
