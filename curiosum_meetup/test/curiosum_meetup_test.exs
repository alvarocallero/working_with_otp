defmodule CuriosumMeetupTest do
  use ExUnit.Case
  doctest CuriosumMeetup

  test "greets the world" do
    assert CuriosumMeetup.hello() == :world
  end
end
