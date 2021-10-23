defmodule AbaeteFestApi.Random do
  def generate_number(size \\ 1) do
    Enum.map(0..(size - 1), fn _ -> Enum.random(1..9) end) |> Enum.join() |> String.to_integer()
  end
end
