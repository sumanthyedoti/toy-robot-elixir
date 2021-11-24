defmodule Playground do
  def new(), do: MultiStorage.new()
  def add_task(tasks, date, body), do: MultiStorage.add(tasks, date, body)
  def get_task(tasks, date), do: MultiStorage.get(tasks, date)
end

defmodule MultiStorage do
  def new(), do: %{}
  def add(storage, key, value) do
    Map.update(storage, key, [value], fn prev_values -> [value | prev_values] end)
  end
  def get(storage, key) do
    Map.get(storage, key, [])
  end
end
