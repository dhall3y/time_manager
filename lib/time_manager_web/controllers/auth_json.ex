defmodule TimeManagerWeb.AuthJSON do
  alias TimeManager.Users.User

  def auth(%{user: user, token: token}) do
    data(user, token)
  end
  
  def error(%{message: message}) do
    %{error: message} 
  end

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      token: token,
    }
  end
end
