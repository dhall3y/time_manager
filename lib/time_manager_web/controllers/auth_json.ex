defmodule TimeManagerWeb.AuthJSON do

  alias TimeManager.Users.User

  def auth(%{user: user, token: token}) do
    data(user, token)
  end
  
  def error(%{message: message}) do
    %{error: message} 
  end

  defp workingtime_data(workingtimes) do
      for(workingtime <- workingtimes, do: %{start: workingtime.start, end: workingtime.end})
  end

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      token: token,
      workingtimes: workingtime_data(user.workingtimes),
      clock: %{
        time: user.clocks.time,
        status: user.clocks.status
      }
    }
  end

end
