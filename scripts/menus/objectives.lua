function RunObjectivesMenu()
  local menu = WarGameMenu(panel(1))
  local titleLabel = Label("Objectives")
  titleLabel:setFont(Fonts["large"])
  menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)
  --local objectives = ""
  --table.foreachi(Objectives, function(k,v) objectives = objectives .. v .. "\n" end)

  local l;
  if (objectives == nil) then
    l = MultiLineLabel("Destroy enemy!")
  else
    l = MultiLineLabel(objectives[1])
  end

  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(114)
  l:adjustSize()
  menu:add(l, 7, 19)

  menu:addFullButton("~!OK", "o", 12, 144 - 30, function() menu:stop() end)

  menu:run()
end

