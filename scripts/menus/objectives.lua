function RunObjectivesMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Objectives", 128 / 2, 11 / 2, Fonts["large"], true)
  --local objectives = ""
  --table.foreachi(Objectives, function(k,v) objectives = objectives .. v .. "\n" end)

  local l = MultiLineLabel(objectives[1])
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(228 / 2)
  l:adjustSize()
  menu:add(l, 14 / 2, 38 / 2)

  menu:addFullButton("~!OK", "o", 25 / 2, 288 / 2 - 60 / 2, function() menu:stop() end)

  menu:run()
end

