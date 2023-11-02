defmodule TimeManagerWeb.UserJSON do
  alias TimeManager.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def error(%{message: message}) do
    %{error: message} 
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  def references_show(%{user: user}) do
    references_data(user)
  end


  defp workingtime_data(workingtimes) do
      for(workingtime <- workingtimes, do: %{start: workingtime.start, end: workingtime.end})
  end

  defp references_data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      workingtimes: workingtime_data(user.workingtimes),
      clock: %{
        time: user.clocks.time,
        status: user.clocks.status
      }
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
    }
  end
end
