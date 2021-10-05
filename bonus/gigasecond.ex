defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    time = NaiveDateTime.from_erl!({{year, month,day}, {hours, minutes, seconds}})
    IO.inspect(time)
    new_time = NaiveDateTime.add(time, 1000*1000*1000, :second)
    IO.inspect(new_time)
    NaiveDateTime.to_erl(new_time)
  end
end