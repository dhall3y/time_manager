defmodule TimeManagerWeb.AuthJSON do
  alias TimeManager.Users.User

  def index(%{user: user}) do
    %{data: data(user)}
  end

  def error(%{message: message}) do
    %{error: message} 
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
    }
  end
end
