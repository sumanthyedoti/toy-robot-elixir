defmodule ToyRobot do
  @moduledoc """
  Documentation for `ToyRobot`.
  """
  @table_top_x 4
  @table_top_y 4

  @doc """
  Places robot in the default place
  """
  def place do
    {:ok, %ToyRobot.Position{}}
  end

  @doc """
  Places robot in the given place
  but prevents it to be placed outside of the table and facing invalid direction.

  Examples:
      iex> ToyRobot.place(1, 2, :south)
      {:ok, %ToyRobot.Position{facing: :south, x: 1, y: 2}}

      iex> ToyRobot.place(-1, -1, :north)
      {:failure, "Invalid position"}

      iex> ToyRobot.place(0, 0, :north_east)
      {:failure, "Invalid facing direction"}
  """
  def place(x, y, _)
      when x < 0 or y < 0 or x > @table_top_x or y > @table_top_y do
    {:failure, "Invalid position"}
  end

  def place(_, _, facing)
      when facing not in [:north, :south, :east, :west] do
    {:failure, "Invalid facing direction"}
  end

  def place(x, y, facing) do
    {
      :ok,
      %ToyRobot.Position{
        x: Enum.min([@table_top_x, x]),
        y: Enum.min([@table_top_y, y]),
        facing: facing
      }
    }
  end

  @doc """
  Reports robot postion and facing, {x, y, facing}
  """
  def report(%ToyRobot.Position{x: x, y: y, facing: facing} = _robot) do
    {x, y, facing}
  end

  @doc """
  Turns robot to right
  """
  @directions_to_the_right %{north: :east, east: :south, south: :west, west: :north}
  def right(%ToyRobot.Position{facing: facing} = robot) do
    # turnRight = fn(facing)  ->
    #   case facing do
    #     :north -> :east
    #     :east -> :south
    #     :south -> :west
    #     :west -> :north
    #   end
    # end
    %ToyRobot.Position{robot | facing: @directions_to_the_right[facing]}
  end

  @doc """
  Turns robot to left
  """
  @directions_to_the_left Enum.map(@directions_to_the_right, fn {from, to} -> {to, from} end)
  def left(%ToyRobot.Position{facing: facing} = robot) do
    # turnLeft = fn(facing)  ->
    #   case facing do
    #     :north -> :west
    #     :west -> :south
    #     :south -> :east
    #     :east -> :north
    #   end
    # end
    %ToyRobot.Position{robot | facing: @directions_to_the_left[facing]}
  end

  # moves the toy robot one unit forward in the direction it is currently facing
  def move(%ToyRobot.Position{x: x, y: y, facing: facing} = robot) do
    case {x, y, facing} do
      {_, y, :north} -> %ToyRobot.Position{robot | y: Enum.min([@table_top_y, y + 1])}
      {_, y, :south} -> %ToyRobot.Position{robot | y: Enum.max([0, y - 1])}
      {x, _, :east} -> %ToyRobot.Position{robot | x: Enum.min([@table_top_x, x + 1])}
      {x, _, :west} -> %ToyRobot.Position{robot | x: Enum.max([0, x - 1])}
    end
  end
end
