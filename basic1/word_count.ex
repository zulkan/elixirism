defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  def split(sentence) do
    String.downcase(sentence)
    |> to_charlist()
    |> Enum.reduce([], fn(val, acc) ->
      if (val >= 48 && val <= 57) do
        #IO.puts("valid num " <> to_string([val]))
        acc ++ [val]
      else
        if (val >= 97 && val <= 122) || val == 45 || val == 39 || val > 127 do
          #IO.puts("valid char " <> to_string([val]))
          acc ++ [val]
        else
          #IO.puts("not valid char " <> to_string([val]))

          acc ++ [' ']
        end
      end
    end)
    |> to_string()
    |> IO.inspect()
    |> String.split(" ")
    |> Enum.filter(fn(str) -> str != "" end)
    |> IO.inspect()
  end

  @spec count(String.t()) :: map
  def count(sentence) do
    split(sentence)
    |> Enum.reduce(%{}, fn(n, acc) ->
      n =
        if String.starts_with?(n, "'") and String.ends_with?(n, "'") do
          IO.puts(n <> "MULAI DENGAN PETIK DAN DIAKHIRI PETIK")
          String.slice(n, 1, String.length(n) - 2)
        else
          n
        end

      IO.inspect(n)
      acc =
        if acc[n] == nil do
          Map.put(acc, n, 1)
        else
          Map.put(acc, n, acc[n] + 1)
        end
      acc
    end)
    |> IO.inspect()
  end


end
