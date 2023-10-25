defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.WorkingTimes
  alias TimeManager.WorkingTimes.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, %{"userID" => id, "start" => startTime, "end" => endTime}) do
    #workingtimes = WorkingTimes.list_workingtimes()
    #render(conn, :index, workingtimes: workingtimes)
    time = WorkingTimes.get_by(id, startTime, endTime)
    render(conn, :index, workingtimes: time)
  end

  def create(conn, %{"userID" => id, "working_time" => working_time_params}) do
    id = String.to_integer(id)
    with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.create_working_time(id, working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{working_time}")
      |> render(:show, working_time: working_time)
    end
  end

  def show(conn, %{"userID" => user_id, "id" => id}) do
    working_time = WorkingTimes.get_one(user_id, id)
    render(conn, :show, working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- WorkingTimes.update_working_time(working_time, working_time_params) do
      render(conn, :show, working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = WorkingTimes.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTimes.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
