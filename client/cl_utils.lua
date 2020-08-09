function draw_help_text(string)
  SetTextComponentFormat("STRING")
  AddTextComponentString(string)
  EndTextCommandDisplayHelp(0, false, true, -1)
end

function fade_screen(time)
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Citizen.Wait(0)
  end
  Citizen.Wait(time)
  DoScreenFadeIn(500)
  while not IsScreenFadedIn() do
    Citizen.Wait(0)
  end
end

function set_player_model(model)
  RequestModel(model)

  while not HasModelLoaded(model) do
    RequestModel(model)
    Citizen.Wait(0)
  end

  SetPlayerModel(PlayerId(), model)
  print("changed")
end