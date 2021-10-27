defmodule AbaeteFestApi.PushNotifications do
  alias AbaeteFestApi.Config
  alias OnesignalElixir.Builder
  [OnesignalElixir.Builder, OnesignalElixir.Notification]

  require Logger

  def send(subject, content) do
    set_keys_for_app()

    body =
      OnesignalElixir.new()
      |> Builder.add_content(:en, content)
      |> Builder.add_heading(:en, subject)
      |> Builder.include_segment("Active Users")
      # |> Builder.include_player_ids(devices)

    case OnesignalElixir.send_notification(body) do
      {:ok, _} ->
        build_log(subject, content)
        |> log()

        :ok

      error ->
        build_log(subject, content, error)
        |> log()

        IO.inspect(error)
    end

    {:ok, :successful_push_notification}
  end

  defp set_keys_for_app() do
    onesignal_id = Config.fetch!(__MODULE__, :onesignal_id)
    onesignal_key = Config.fetch!(__MODULE__, :onesignal_key)

    Application.put_env(:onesignal_elixir, :app_id, onesignal_id)

    Application.put_env(
      :onesignal_elixir,
      :rest_api_key,
      onesignal_key
    )
  end

  defp build_log(subject, content) do
    id = Application.get_env(:onesignal_elixir, :app_id)
    key = Application.get_env(:onesignal_elixir, :rest_api_key)

    %{
      id: id,
      key: key,
      subject: subject,
      content: content
    }
  end

  defp build_log(subject, content, error) do
    build_log(subject, content)
    |> Map.put(:error, error)
  end

  defp log(data) do
    Logger.info("Sending Push notification: #{inspect(data)}")
  end
end
