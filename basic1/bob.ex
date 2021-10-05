defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)
    has_alphabet = String.match?(input, ~r/[A-Za-z]/)
    has_non_ascii =   Enum.reduce(
      String.to_char_list(input),
      false,
      fn (val, acc) ->
        if val > 127 do
          true
        else
          acc
        end
      end
    )

    is_upcased = input == String.upcase(input)
    is_question = String.ends_with?(input, "?")


    cond do
      input == "" -> "Fine. Be that way!"
      is_question && is_upcased && (has_alphabet || has_non_ascii) -> "Calm down, I know what I'm doing!"
      is_question -> "Sure."
      is_upcased && (has_alphabet || has_non_ascii) -> "Whoa, chill out!"
      true -> "Whatever."
    end

  end
end