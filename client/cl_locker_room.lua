local config = {}
config.locker_rooms = { 
  vector3(451.42, -993.0, 30.69),
  vector3(1857.13, 3689.3, 34.27),
  vector3(-449.73, 6016.39, 31.72),
  vector3(360.63, -1584.37, 29.29),
  vector3(-1108.17, -845.06, 19.32),
  vector3(638.69, 1.65, 82.79)
}

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

Citizen.CreateThread(function() 
  while true do
    draw_locker_room_markers()
    Citizen.Wait(0)
  end
end)