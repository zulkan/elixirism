import Kernel, except: [length: 1, map: 2]

defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec length(list) :: non_neg_integer
  def length(l) do
    if l == [] do
      0
    else
      [_ | next] = l
      length(next) + 1
    end
  end

  def take_last(list) do
    [first | remaining] = list

    cond do
      list == [] -> nil
      remaining == [] -> first
      true -> take_last(remaining)
    end
  end

  def extract_first_n_element(list, n) do
    cond do
      n <= 0 -> list
      n == 1 ->
        [first | _] = list
        [first]
      true ->
        [first | remaining] = list
        [first | extract_first_n_element(remaining, n - 1)]
    end
  end

  def list_to_map([]), do: %{}
  def list_to_map([v | []], additional_idx = 0), do: %{additional_idx => v}
  def list_to_map([v | rem], additional_idx = 0) do
    back = list_to_map(rem, additional_idx + 1)
    Map.put(back, additional_idx, v)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    size = length(l)
    cond do
      l == [] -> []
      size == 1 -> l
      true ->
        last = take_last(l)
        front_list = reverse(extract_first_n_element(l, size - 1))
        [last | front_list]
    end
  end

  def map([], _), do: []
  def map([v | []], f), do: [f.(v)]

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    [first | remaining] = l
    append([f.(first)], map(remaining, f))
  end

  def filter([], _), do: []
  def filter([v | []], f) do
    if f.(v) do
      [v]
    else
      []
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    [first | remaining] = l
    append(filter([first], f), filter(remaining, f))
  end

  def foldl([], acc, f), do: acc
  def foldl([first| []], acc, f) do
    f.(first, acc)
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f) do
    [first | remaining] = l
    first_result = f.(first, acc)
    foldl(remaining, first_result, f)
  end


  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    foldl(reverse(l), acc, f)
  end

  def append([], b), do: b
  def append([a | []], b), do: [a | b]
  def append(a, []), do: a

  @spec append(list, list) :: list
  def append(a, b) do
    size_a = length(a)
    front_a = extract_first_n_element(a, size_a - 1)
    last_a = take_last(a)
    append(front_a, [last_a | b])
  end

  def concat([]), do: []

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    [v | rem] = ll
    append(v, concat(rem))
  end
end

#IO.inspect(ListOps.lengthR([1,2,3,51412, 4321222, "dss", 55]))

wanted = [1, 2, 3, 51412, 4321222, 55]
IO.inspect(ListOps.reverse(wanted))
IO.inspect(ListOps.concat([[1,2,3], [4,5]]))

#IO.inspect(ListOps.extract_first_n_element(wanted, 5))