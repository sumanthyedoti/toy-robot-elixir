defmodule ToyRobot.CLI do
  def main(_args) do
    IO.puts("Welcome to the Toy Robot simulator!")
    print_help_message()
    receive_command()
  end

  @commands %{
    "quit" => "Quits the simulator",
    "place" =>
      ~s(format: "place: [X, Y, F].") <>
        "Places the Robot into X,Y facing F (Default is 0,0,North). ",
    "report" => "The Toy Robot reports about its position",
    "left" => "Rotates the robot to the left",
    "right" => "Rotates the robot to the right",
    "move" => "Moves the robot one position forward"
  }

  defp print_help_message do
    IO.puts("\nThe simulator supports following commands:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end

  defp print_help_message(commands) do
    IO.puts("\The commands you may need:\n")

    commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end

  defp receive_command(robot \\ nil) do
    IO.gets("\n> ")
    |> String.trim()
    |> String.downcase()
    |> String.split(" ")
    |> Enum.filter(&(&1 != ""))
    |> execute_command(robot)
  end

  defp execute_command(["place"], _robot) do
    {:ok, robot} = ToyRobot.place()
    robot |> receive_command()
  end

  defp execute_command(["place" | params], _robot) do
    {x, y, facing} = process_params(params)

    case ToyRobot.place(x, y, facing) do
      {:ok, robot} ->
        receive_command(robot)

      {:failure, message} ->
        IO.puts(message)
        receive_command()
    end
  end

  defp execute_command(["report"], nil) do
    IO.puts("The robot is not placed yet!")
    print_help_message(Map.take(@commands, ["place"]))
    receive_command()
  end

  defp execute_command(["left"], robot) do
    robot |> ToyRobot.left() |> receive_command
  end

  defp execute_command(["right"], robot) do
    robot |> ToyRobot.right() |> receive_command
  end

  defp execute_command(["move"], robot) do
    robot |> ToyRobot.move() |> receive_command
  end

  defp execute_command(["report"], robot) do
    {x, y, facing} = robot |> ToyRobot.report()
    IO.puts(String.upcase("#{x},#{y},#{facing}"))
    receive_command(robot)
  end

  defp execute_command(["quit"], _robot) do
    IO.puts("\nQuitting..")
  end

  defp execute_command(_unknown, _robot) do
    IO.puts("\nInvalid command. I don't know what to do.")
    print_help_message()

    receive_command()
  end

  defp process_params(params) do
    [x, y, facing] = params |> Enum.join(" ") |> String.split(",") |> Enum.map(&String.trim/1)
    {String.to_integer(x), String.to_integer(y), String.to_atom(facing)}
  end
end
