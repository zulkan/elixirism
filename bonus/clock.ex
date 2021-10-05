defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """

  def mod(num, sep) when num < 0 do
    mod(num + sep, sep)
  end

  def mod(num, sep) do
    rem(num, sep)
  end

  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    new_minute = mod(minute, 60)
    hour_adder =
      if minute < 0 do
          div(minute-59, 60)
        else
          div(minute, 60)
      end
    IO.inspect("ADDER #{hour_adder}")
    %Clock{hour: mod(hour + hour_adder, 24), minute: new_minute}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new_minute = mod(minute + add_minute, 60)
    hour_adder =
      if minute + add_minute < 0 do
        div(minute + add_minute-59, 60)
      else
        div(minute + add_minute, 60)
      end
    new_hour = mod(hour + hour_adder, 24)
    %Clock{hour: new_hour, minute: new_minute}
  end
end

defimpl String.Chars, for: Clock do
  def pad_zero(num) do
    if num < 10 do
      "0#{num}"
      else
      "#{num}"
    end
  end
  def to_string(%Clock{hour: hour, minute: minute}), do: "#{pad_zero(hour)}:#{pad_zero(minute)}"
end

v = Clock.new(1,-40)
to_string(v)
|> IO.inspect