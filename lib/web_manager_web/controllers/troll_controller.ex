defmodule WebManagerWeb.TrollController do
  use WebManagerWeb, :controller
  alias WebManager.Photos
  require Logger

  def check(conn, _params) do
    troll_mode = Photos.last_troll()
    Logger.warn(inspect WebManager.Repo.all(Photos.Troll))
    Photos.clear_troll()
    Logger.warn(inspect WebManager.Repo.all(Photos.Troll))
    

    Logger.warn("Troll value of #{troll_mode} 🏴‍")
    conn
    |> put_resp_header("cache-control", "no-store")
    |> json(%{troll: troll_mode})
  end
  
  def set(conn, _params) do
    Photos.create_troll(true)
    
    text conn, "Trolling!"
  end
end
