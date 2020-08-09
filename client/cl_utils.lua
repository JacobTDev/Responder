function DrawHelpText(string)
  SetTextComponentFormat("STRING")
  AddTextComponentString(string)
  EndTextCommandDisplayHelp(0, true, true, -1)
end