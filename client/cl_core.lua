-- Responder Menu
Citizen.CreateThread(function() 
  -- Uniform setup
  local uniforms = {"LSPD", "SAHP", "BCSO"}
  local uniform_hashes = {"s_m_y_cop_01", "s_m_y_hwaycop_01", "csb_cop"}
  local current_item_index = 1
  local selected_item_index = 1

  WarMenu.CreateMenu("responder-menu", "Responder")
  
  while true do 
    if WarMenu.IsMenuOpened("responder-menu") then
      if in_locker_room then
        if WarMenu.ComboBox("Uniform", uniforms, current_item_index, selected_item_index, function(current_index, selected_index) 
          if current_item_index ~= current_index then
            set_player_model(uniform_hashes[current_index])
            selected_index = current_index
            selected_item_index = current_index
            current_item_index = current_index
          else
            current_item_index = current_index
            selected_item_index = selected_index
          end
        end) then
        elseif WarMenu.Button("Cancel") then
          exit_locker_room()
        elseif WarMenu.Button("Confirm") then
          exit_locker_room()
          --TODO: SET ON DUTY STATUS
        end
      else
        --TODO: SHOW NORMAL RESPONDER MENU
      end

      WarMenu.Display()
    elseif in_locker_room then
      WarMenu.OpenMenu("responder-menu")
    elseif IsControlJustReleased(1, 244) then
      print("hi")
      WarMenu.OpenMenu("responder-menu")
    else 
      WarMenu.CloseMenu()
		end    

    Citizen.Wait(0)
  end
end)
