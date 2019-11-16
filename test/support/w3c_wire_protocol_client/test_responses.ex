defmodule WebDriverClient.W3CWireProtocolClient.TestResponses do
  @moduledoc false
  use ExUnitProperties

  def fetch_window_rect_response do
    window_rect_response() |> map(&Jason.encode!/1)
  end

  def set_window_rect_response do
    window_rect_response() |> map(&Jason.encode!/1)
  end

  def fetch_current_url_response do
    fixed_map(%{"value" => url()}) |> map(&Jason.encode!/1)
  end

  def fetch_log_types_response do
    %{"value" => list_of(string(:alphanumeric), max_length: 10)}
    |> fixed_map()
    |> map(&Jason.encode!/1)
  end

  def fetch_logs_response do
    %{"value" => list_of(log_entry(), max_length: 10)}
    |> fixed_map()
    |> map(&Jason.encode!/1)
  end

  def log_entry do
    fixed_map(%{
      "timestamp" => recent_timestamp(),
      "level" => log_level(),
      "message" => log_message()
    })
  end

  def log_message do
    string(:printable)
  end

  def log_level do
    string(:alphanumeric, min_length: 1, max_length: 10)
  end

  def log_type do
    string(:alphanumeric, min_length: 1, max_length: 10)
  end

  defp window_rect_response do
    fixed_map(%{
      "value" =>
        fixed_map(%{
          "x" => integer(),
          "y" => integer(),
          "width" => integer(0..1000),
          "height" => integer(0..1000)
        })
    })
  end

  defp url do
    constant("http://foo.com")
  end

  defp recent_timestamp do
    map(
      integer(),
      &(DateTime.utc_now()
        |> DateTime.to_unix(:millisecond)
        |> Kernel.+(&1))
    )
  end
end