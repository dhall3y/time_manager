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


  defp workingtimes_data(workingtimes) do
      for(workingtime <- workingtimes, do: %{start: workingtime.start, end: workingtime.end})
  end

  defp clocks_data(clocks) do
      for(clock <- clocks, do: %{start: clock.start, end: clock.end, status: clock.status})
  end

  defp references_data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      manager_id: user.manager_id,
      teams_id: user.teams_id,
      managed_teams: user.managed_teams,
      workingtimes: workingtimes_data(user.workingtimes),
      clocks: clocks_data(user.clocks)
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
