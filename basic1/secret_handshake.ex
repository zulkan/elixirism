defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    mapper =  %{0 => "wink", 1 => "double blink", 2 => "close your eyes", 3 => "jump"}
    code =
      Integer.to_string(code, 2)
      |> String.graphemes()
      |> IO.inspect()

    res =
      Enum.reduce(0..Enum.count(code)-1, [], fn(v, acc) ->
        pos = Enum.count(code)-1-v
        cond do
          Enum.at(code, pos) == "1" && v == 4 -> Enum.reverse(acc)
          Enum.at(code, pos) == "1" && mapper[v] != nil -> acc ++ [mapper[v]]
          true -> acc
        end
        |> IO.inspect()


      end)

    res
  end
end
