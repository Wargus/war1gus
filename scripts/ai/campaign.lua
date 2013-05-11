DefineAi("camp01", "*", "camp01", AiPassive)

function Ai02()
   local loop_funcs = {
      function()
	 AiForce(0, {AiSoldier(), 1})
	 if not AiCheckForce(0) then AiForce(0, {AiShooter(), 1}) end
	 return AiSleep(9000)
      end,
      function() return AiAttackWithForce(0) end,
      
      function()
	 AiForce(0, {AiShooter(), 1})
	 if not AiCheckForce(0) then AiForce(0, {AiSoldier(), 1}) end
	 return AiSleep(9000)
      end,
      function() return AiAttackWithForce(0) end,
      
      function()
	 stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = 0
	 return false
      end
   }
   return function()
      return AiLoop(loop_funcs, stratagus.gameData.AIState.loop_index)
   end
end
DefineAi("camp02", "*", "camp02", Ai02())

DefineAi("camp03", "*", "camp03", CreateAiLandAttack(7))
DefineAi("camp04", "*", "camp04", AiPassive)
DefineAi("camp05", "*", "camp05", CreateAiLandAttack(6))
DefineAi("camp06", "*", "camp06", CreateAiLandAttack(5))
DefineAi("camp07", "*", "camp07", CreateAiLandAttack(4))
DefineAi("camp08", "*", "camp08", AiPassive)
DefineAi("camp09", "*", "camp09", CreateAiLandAttack(3))
DefineAi("camp10", "*", "camp10", CreateAiLandAttack(4))
DefineAi("camp11", "*", "camp11", CreateAiLandAttack(2))
DefineAi("camp12", "*", "camp12", CreateAiLandAttack(1))
