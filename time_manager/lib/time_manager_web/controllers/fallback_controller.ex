defmodule TimeManagerWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use TimeManagerWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: TimeManagerWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: TimeManagerWeb.ErrorHTML, json: TimeManagerWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :user_not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: TimeManagerWeb.ErrorJSON)
    |> render("404.json", message: "User not found")
  end

  def call(conn, {:error, :workingtime_not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: TimeManagerWeb.ErrorJSON)
    |> render("404.json", message: "No working times found for user")
  end
end
