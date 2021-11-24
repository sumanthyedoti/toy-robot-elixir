defmodule ToyRobot.Position do
  @type t :: %__MODULE__{
          x: integer(),
          y: integer(),
          facing: :north | :south | :east | :west
        }
  defstruct x: 0, y: 0, facing: :north
end
