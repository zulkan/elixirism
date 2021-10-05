defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) when number >= 1000 do
    "M" <> numeral(number - 1000)
  end
  def numeral(number) when number >= 500 do
    if number >= 900 do
      "CM" <> numeral(number - 900)
    else
      "D" <> numeral(number - 500)
    end
  end
  def numeral(number) when number >= 100 do
    if number >= 400 do
      "CD" <> numeral(number - 400)
    else
      "C" <> numeral(number - 100)
    end
  end
  def numeral(number) when number >= 50 do
    if number >= 90 do
      "XC" <> numeral(number - 90)
    else
      "L" <> numeral(number - 50)
    end
  end
  def numeral(number) when number >= 10  do
    if number >= 40 do
      "XL" <> numeral(number - 40)
    else
      "X" <> numeral(number - 10)
    end
  end
  def numeral(number) when number >= 5  do
    if number >= 9 do
      "IX" <> numeral(number - 9)
    else
      "V" <> numeral(number - 5)
    end
  end
  def numeral(number) when number >= 1  do
    if number >= 4 do
      "IV" <> numeral(number - 4)
    else
      "I" <> numeral(number - 1)
    end
  end
  def numeral(0) do
    ""
  end

end
