defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  def create(), do: %{direction: :north, position: {0, 0}}

  def create(direction, _) when direction not in [:north, :south, :east, :west] do
    {:error, "invalid direction"}
  end

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction, position = {x, y}) do
    if is_integer(x) && is_integer(y) do
      %{direction: direction, position: position}
    else
      {:error, "invalid position"}
    end
  end

  def create(_, _) do
    {:error, "invalid position"}
  end

  def change_direction(:north, "R"), do: :east
  def change_direction(:north, "L"), do: :west
  def change_direction(:east, "R"), do: :south
  def change_direction(:east, "L"), do: :north
  def change_direction(:south, "R"), do: :west
  def change_direction(:south, "L"), do: :east
  def change_direction(:west, "R"), do: :north
  def change_direction(:west, "L"), do: :south

  def move({x,y}, {d1, d2}), do: {x+d1, y+d2}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    move_direction = %{
      north: {0, 1},
      east: {1, 0},
      west: {-1, 0},
      south: {0, -1}
    }
    instructions_array = String.graphemes(instructions)
                         |> IO.inspect()
    cond do
      Enum.any?(instructions_array, fn(v) -> v not in ["A", "R", "L"] end) ->
        {:error, "invalid instruction"}
      true ->
        Enum.reduce(instructions_array, robot, fn(v,acc) ->
          if v == "A" do
            %{direction: acc[:direction], position: move(acc[:position], move_direction[acc[:direction]] ) }
          else
            next_direction = change_direction(acc[:direction], v)
            %{direction: next_direction, position: acc[:position]}
          end
        end)
    end

  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot[:direction]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot[:position]
  end
end
