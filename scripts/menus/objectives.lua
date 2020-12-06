function RunObjectivesMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Objectives", 64, 5, Fonts["large"], true)
  --local objectives = ""
  --table.foreachi(Objectives, function(k,v) objectives = objectives .. v .. "\n" end)

  local l = MultiLineLabel(objectives[1])
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(114)
  l:adjustSize()
  menu:add(l, 7, 19)

  menu:addFullButton("~!OK", "o", 12, 144 - 30, function() menu:stop() end)

  menu:run()
end

