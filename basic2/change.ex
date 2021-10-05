defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """
  def bfs(dp, _, _, 0), do: dp

  def bfs(dp, coins, target, left) do

    #        IO.inspect(dp, label: "bef")
    dp = for cur <- Map.keys(dp), add <- coins, reduce: dp do
      acc ->
        next = cur + add
        if acc[next] == nil && next <= target do
          Map.put(acc, next, [add | acc[cur]] )
        else
          acc
        end
    end
    #        IO.inspect(dp, label: "after")

    bfs(dp, coins, target, left - 1)
  end

  def generate(coins, target) do
    res = bfs(%{0 => []}, coins, target, 1000)
    #      |> IO.inspect()

    if res[target] != nil do

      {:ok, Enum.sort(res[target]) }
    else
      {:error, "cannot change"}
    end
  end

end

v = Change.generate([1,5,10,21,25], 63)
IO.inspect(v)