defmodule Cols do
    def map(lst, fun), do: _map(lst, fun, [])
    defp _map([], _fun, newlist), do: newlist
    defp _map([head | tail], fun, []), do: _map(tail, fun, [fun.(head)])
    defp _map([head | tail], fun, newlist), do: _map(tail, fun, newlist ++ [fun.(head)])

    def reduce([], value, _fun), do: value
    def reduce([head | tail], value, fun), do: reduce(tail, fun.(head, value), fun)

    def mapsum([], _fun), do: 0
    def mapsum(lst, fun) do
      lst
        |> map(fun)
        |> reduce(0, &(&1+&2))
    end

    def replace_at(lst, index, val), do: _replace_at(lst, index, val, [], 0)
    def _replace_at([], _index, _val, newlist, curr), do: newlist
    def _replace_at([_head | tail], index, val, newlist, index), do: newlist ++ [val] ++ tail
    def _replace_at([head | tail], index, val, newlist, curr), do: _replace_at(tail, index, val, newlist ++ [head], curr+1)

    def filter(lst, fun), do: _filter(lst, fun, [])
    def _filter([], _fun, newlist), do: newlist
    def _filter([head | tail], fun, newlist) do
      if fun.(head) do
       _filter(tail, fun, newlist ++ [head])
      else
        _filter(tail, fun, newlist)
      end
    end
end