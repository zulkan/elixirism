defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """
  use GenServer


  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  def init(init_arg) do
    {:ok, init_arg}
  end

  def handle_call(:balance, from, state) do
    IO.inspect(from, label: "handle call arg 2")
    IO.inspect(state, label: "handle call arg 3")

    cond do
      state[:is_closed] == true -> {:reply, {:error, :account_closed}, state}
      true -> {:reply, state[:amount], state}
    end

  end
  def handle_cast(:close_bank, state), do: {:noreply, %{amount: state[:amount], is_closed: true}}
  def handle_cast({:update, amount}, state), do: {:noreply, %{amount: state[:amount] + amount, is_closed: false}}

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    rand_name = for _ <- 1..10, into: "", do: <<Enum.random('0123456789abcdef')>>
    rand_name = String.to_atom(rand_name)
    {:ok, pid} = GenServer.start(__MODULE__, %{amount: 0, is_closed: false}, name: rand_name)
    pid
    #    GenServer.start_link(self(), %{is_closed: false, amount: 0})
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.cast(account, :close_bank)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    val = GenServer.call(account, :balance)
    cond do
      is_tuple(val) -> val
      true -> GenServer.cast(account, {:update, amount})
    end
  end
end