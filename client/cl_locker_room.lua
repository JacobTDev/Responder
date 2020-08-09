-- FIXME: No blip sprites on map and 100s of them (bug?)

in_locker_room = false

local config = {}
config.min_distance_to_locker_room = 3.0
config.locker_rooms = { 
  vector3(451.42, -993.0, 30.69),
  vector3(1857.13, 3689.3, 34.27),
  vector3(-449.73, 6016.39, 31.72),
  vector3(360.63, -1584.37, 29.29),
  vector3(-1108.17, -845.06, 19.32),
  vector3(638.69, 1.65, 82.79)
}

AddEventHandler("onClientResourceStart", function() 
  add_locker_room_blips()
end)

function add_locker_room_blips() 
  for k, v in ipairs(config.locker_rooms) do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blip, 60)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 1)
    SetBlipColour(blip, 0)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Locker Room")
    EndTextCommandSetBlipName(blip)
  end
end

function draw_locker_room_markers()
  for k, v in ipairs(config.locker_rooms) do
    DrawMarker(21, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 187, 249, 255, true, true, 2, nil, nil, false)
  end
end

function player_locker_room_check()
  local plyCoords = GetEntityCoords(GetPlayerPed(-1))

  for k, v in ipairs(config.locker_rooms) do 
    if #(plyCoords - v) <= config.min_distance_to_locker_room then
      if not in_locker_room then
        draw_help_text("Press ~INPUT_VEH_HORN~ to enter locker room.")
        if IsControlJustReleased(1, 86) then
          --TODO: IF ON DUTY SET THEM AS OFF DUTY
          enter_locker_room()
        end
      else
        if IsControlJustReleased(1, 86) then
          exit_locker_room()
        end
      end
    end
  end
end

function enter_locker_room()
  fade_screen(4000)
  WarMenu.CloseMenu()
  set_player_model("s_m_y_cop_01")
  in_locker_room = true
  FreezeEntityPosition(GetPlayerPed(-1), true)
end

function exit_locker_room()
  fade_screen(4000)
  in_locker_room = false
  WarMenu.CloseMenu()
  FreezeEntityPosition(GetPlayerPed(-1), false)
end

function clear_player_tasks()
  ClearPedTasksImmediately(GetPlayerPed(-1))
end

Citizen.CreateThread(function() 
  while true do
    draw_locker_room_markers()
    player_locker_room_check()

    if in_locker_room then
      clear_player_tasks()
    end

    Citizen.Wait(0)
  end
end)