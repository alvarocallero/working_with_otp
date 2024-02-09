defmodule CuriosumMeetup.NotificationSender do
  @callback send_message(recipient :: String.t(), message :: String.t()) :: :ok | {:error, String.t()}
end

defmodule CuriosumMeetup.EmailSender do
  @behaviour CuriosumMeetup.NotificationSender

  def send_message(email_address, message) do
    email_address
    |> build_email()
    |> format_body(message)
    |> send_email()
  end

  defp build_email(email_address), do: email_address
  defp format_body(email, message), do: message <> email
  defp send_email(email), do: email

end

defmodule CuriosumMeetup.SmsSender do
  @behaviour CuriosumMeetup.NotificationSender

  def send_message(phone_number, message) do
    phone_number
    |> set_connection()
    |> send_text(message)
  end

  defp set_connection(phone_number), do: phone_number
  defp send_text(phone_number, message), do: message <> phone_number

end
