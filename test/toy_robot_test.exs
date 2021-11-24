defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot

  test "Does not place robot in invalid postion" do
    {response, _} = ToyRobot.place(6, 6, :east)
    assert response == :failure
  end

  test "Does not place robot with invalid facing" do
    {response, _} = ToyRobot.place(2, 2, :up)
    assert response == :failure
  end

  test "places the Toy Robot on the table in the default position" do
    assert ToyRobot.place() == {:ok, %ToyRobot.Position{x: 0, y: 0, facing: :north}}
  end

  test "places the Toy Robot on the table in the specified position" do
    assert ToyRobot.place(1, 2, :east) == {:ok, %ToyRobot.Position{x: 1, y: 2, facing: :east}}
  end

  test "provides the report of robot's position" do
    {:ok, robot} = ToyRobot.place(2, 3, :west)
    assert ToyRobot.report(robot) == {2, 3, :west}
  end

  test "rotates robot to right" do
    {:ok, robot} = ToyRobot.place()
    position = robot |> ToyRobot.right() |> ToyRobot.report()
    assert position == {0, 0, :east}

    {:ok, robot} = ToyRobot.place(1, 2, :south)
    position = robot |> ToyRobot.right() |> ToyRobot.report()
    assert position == {1, 2, :west}

    {:ok, robot} = ToyRobot.place(1, 2, :south)

    position =
      robot
      |> ToyRobot.right()
      |> ToyRobot.right()
      |> ToyRobot.right()
      |> ToyRobot.report()

    assert position == {1, 2, :east}
  end

  test "rotates robot to left" do
    {:ok, robot} = ToyRobot.place()
    position = robot |> ToyRobot.left() |> ToyRobot.report()
    assert position == {0, 0, :west}

    {:ok, robot} = ToyRobot.place(3, 3, :west)
    position = robot |> ToyRobot.left() |> ToyRobot.report()
    assert position == {3, 3, :south}

    {:ok, robot} = ToyRobot.place(3, 3, :west)

    position =
      robot
      |> ToyRobot.left()
      |> ToyRobot.left()
      |> ToyRobot.left()
      |> ToyRobot.report()

    assert position == {3, 3, :north}
  end

  test "moves robot up if it is facing north" do
    {:ok, robot} = ToyRobot.place(1, 2, :north)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {1, 3, :north}
  end

  test "moves robot down if it is facing south" do
    {:ok, robot} = ToyRobot.place(1, 2, :south)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {1, 1, :south}
  end

  test "moves robot right if it is facing east" do
    {:ok, robot} = ToyRobot.place(1, 2, :east)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {2, 2, :east}
  end

  test "moves robot left if it is facing west" do
    {:ok, robot} = ToyRobot.place(2, 2, :west)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {1, 2, :west}
  end

  test "prevents the robot to fall at north" do
    {:ok, robot} = ToyRobot.place(1, 4, :north)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {1, 4, :north}
  end

  test "prevents the robot to fall at south" do
    {:ok, robot} = ToyRobot.place(0, 0, :south)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {0, 0, :south}
  end

  test "prevents the robot to fall at east" do
    {:ok, robot} = ToyRobot.place(4, 2, :east)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {4, 2, :east}
  end

  test "prevents the robot to fall at west" do
    {:ok, robot} = ToyRobot.place(0, 2, :west)
    position = robot |> ToyRobot.move() |> ToyRobot.report()
    assert position == {0, 2, :west}
  end
end
