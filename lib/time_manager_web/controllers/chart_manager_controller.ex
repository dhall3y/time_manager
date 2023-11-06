defmodule TimeManagerWeb.ChartManagerController do
  use TimeManagerWeb, :controller

  action_fallback TimeManagerWeb.FallbackController

  def show(conn, %{"teams" => teams, "start" => startTime, "end" => endTime}) do
    
  end

end
