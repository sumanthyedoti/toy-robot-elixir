Toy Robot simulator on a 4x4 table.

Placed at a position, it can turn `right`, `left`, `move` one step forward in the
direction it is facing, and `report` the current position and direction it is
facing.

The robot is smart enough not to jump off the edge if you say so.

### Start the application:

```
cd ../into/the/directory
iex -S mix
```

### Robot in action:

```elixir
iex> {:ok, robot} = ToyRobot.place(1, 1, :east))
iex> robot = robot |> ToyRobot.move
iex> robot |> ToyRobot.report
{2, 1, :east}
iex> robot = robot |> ToyRobot.right |> ToyRobot.move
iex> robot |> ToyRobot.report
{2, 0, :south}
```

### Run tests

```
mix test
```
