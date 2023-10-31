defmodule TimeManagerWeb.AuthController do
  use TimeManagerWeb, :controller

  alias TimeManager.Users
  alias TimeManager.Users.User

  action_fallback TimeManagerWeb.FallbackController

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Users.get_by_email(email) do
      %User{} = user -> 
        case Bcrypt.verify_pass(password, user.password) do
          true ->
            render(conn, :index, user: user)
          false -> 
            render(conn, :error, message: "Incorrect password")
        end
      _ -> render(conn, :error, message: "User not found") 
    end
  end

  def sign_out(conn, _params) do
    render(conn, :error, message: "sign_out not working")
  end
end 
