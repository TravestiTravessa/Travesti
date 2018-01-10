require("OpenPredict")

if GetObjectName(GetMyHero()) ~= "Irelia" then return end

local IreliaMenu = Menu("Irelia", "Travesti Irelia")

IreliaMenu:SubMenu("Combo", "Combo")
IreliaMenu.Combo:Boolean("Q", "Use Q", true)
IreliaMenu.Combo:Boolean("W", "Use W", true)
IreliaMenu.Combo:Boolean("E", "Use E", true)
IreliaMenu.Combo:Boolean("R", "Use R", true)
IreliaMenu.Combo:Boolean("Ign", "Auto Ignite", true)

IreliaMenu:SubMenu("Harras", "Harras")
IreliaMenu.Harras:Boolean("Q", "Use Q", true)
IreliaMenu.Harras:Boolean("W", "Use W", true)
IreliaMenu.Harras:Boolean("E", "Use E", true)
IreliaMenu.Harras:Slider('ManaManager', 'Min % Mana', 50, 10, 100, 1)

IreliaMenu:SubMenu("Farm", "Farm")
IreliaMenu.Farm:Boolean("Q", "Use Q", true)
IreliaMenu.Farm:Boolean("W", "Use W", false)
IreliaMenu.Farm:Boolean("E", "Use E", true)
IreliaMenu.Farm:Slider('ManaManager', 'Min % Mana', 50, 10, 100, 1)

IreliaMenu:SubMenu("Ks", "Killsteal")
IreliaMenu.Ks:Boolean("Q", "Use Q", true)
IreliaMenu.Ks:Boolean("W", "Use W", true)
IreliaMenu.Ks:Boolean("E", "Use E", true)
IreliaMenu.Ks:Boolean("R", "Use R", true)

IreliaMenu:SubMenu("misc", "Misc Settings")

IreliaMenu:SubMenu("drawing", "Draw Settings")
IreliaMenu.drawing:Boolean("DrawQ", "Use Draw Q", true)
IreliaMenu.drawing:Boolean("DrawW", "Use Draw W", true)
IreliaMenu.drawing:Boolean("DrawE", "Use Draw E", true)
IreliaMenu.drawing:Boolean("DrawR", "Use Draw R", true)


local IreliaR = {delay = .5, range = 1000, width = 120, speed = 1600 }

local nextAttack = 0

OnProcessSpell(function(unit,spellProc)
	if unit.isMe and spellProc.name:lower():find("attack") and spellProc.target.isHero then
		nextAttack = GetTickCount() + spellProc.windUpTime * 1000
	end

end)

OnTick(function ()
	    Killsteal()
		if IOW:Mode() == "Combo" then Combo() end
		if IOW:Mode() == "Harras" then Harras() end
		if IOW:Mode() == "LaneClear" then Farm() end

end)

function Farm()

		for _,closeminion in pairs(minionManager.objects) do
			if GetCurrentMana(myHero) >= IreliaMenu.Farm.ManaManager:Value() then
				if IreliaMenu.Farm.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 650) then
					if GetTickCount() > nextAttack then
						if GetCurrentHP(closeminion) < CalcDamage(myHero, closeminion, 0, 30 + 30 * GetCastLevel(myHero,_Q)) then
							CastTargetSpell(closeminion, _Q)
						end
					end
				end
			end

			if GetCurrentMana(myHero) >= IreliaMenu.Farm.ManaManager:Value() then
				if IreliaMenu.Farm.W:Value() and Ready(_W) and ValidTarget(closeminion, GetRange(myHero)) and MinionsAround(myHero, GetRange(myHero)) > 1 then
				    CastSpell(_W)
				end
			end

			if GetCurrentMana(myHero) >= IreliaMenu.Farm.ManaManager:Value() then
				if IreliaMenu.Farm.E:Value() and Ready(_E) and ValidTarget(closeminion, 325) then
					CastTargetSpell(closeminion, _E)
				end
			end
		end

end

function Harras()
local target = GetCurrentTarget()

            if IreliaMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 650) then
             	CastTargetSpell(target , _Q)
            end
			if IreliaMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, GetRange(myHero)) then
             	CastSpell(_W)
            end
			if IreliaMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 325) then
             	CastTargetSpell(target , _E)
            end

end

function Combo()
local target = GetCurrentTarget()

            if IreliaMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 650) then
             	CastTargetSpell(target , _Q)
            end
			if IreliaMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, GetRange(myHero)) then
             	CastSpell(_W)
            end
			if IreliaMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 325) then
             	CastTargetSpell(target , _E)
            end
			if IreliaMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 1000) then
                        local RPred = GetPrediction(target,IreliaR)
                        if RPred.hitChance > 0.7 then
                              CastSkillShot(_R,RPred.castPos)
                        end
            end

			AutoIgnite()

end

function Killsteal()
	for _, enemy in pairs(GetEnemyHeroes()) do
		if IreliaMenu.Ks.Q:Value() and Ready(_Q) and ValidTarget(enemy, 650) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 0 + 30 * GetCastLevel(myHero,_Q)) then
	           		CastTargetSpell(enemy , _Q)
			end
		end

		if IreliaMenu.Ks.W:Value() and Ready(_W) and ValidTarget(enemy, GetRange(myHero)) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 15 + 15 * GetCastLevel(myHero,_W)) then
	           		CastSpell(_W)
			end
		end

	    if IreliaMenu.Ks.E:Value() and Ready(_E) and ValidTarget(enemy, 325) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 40 + 40 * GetCastLevel(myHero,_E) + GetBonusAP(myHero) * 0.5) then
	           		CastTargetSpell(enemy , _E)
			end
		end

	    if IreliaMenu.Ks.R:Value() and Ready(_R) and ValidTarget(enemy, 1000) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 40 + 40 * GetCastLevel(myHero,_R) + GetBonusAP(myHero) * 0.5) then
					    local RPred = GetPrediction(enemy,IreliaR)
                        if RPred.hitChance > 0.7 then
                              CastSkillShot(_R,RPred.castPos)
                        end
			end
		end

	end
end

OnDraw(function(myHero)

	local pos = GetOrigin(myHero)

	if IreliaMenu.drawing.DrawQ:Value() and Ready(_Q) then DrawCircle(pos, 650, 1, 25, GoS.White) end
	if IreliaMenu.drawing.DrawW:Value() and Ready(_W) then DrawCircle(pos, GetRange(myHero), 1, 25, GoS.Green) end
	if IreliaMenu.drawing.DrawE:Value() and Ready(_E) then DrawCircle(pos, 325, 1, 25, GoS.Yellow) end
	if IreliaMenu.drawing.DrawR:Value() and Ready(_R) then DrawCircle(pos, 1000, 1, 25, GoS.Cyan) end

end)

function AutoIgnite()
	for _, enemy in pairs(GetEnemyHeroes()) do
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
			if IreliaMenu.Combo.Ign:Value() and Ready(SUMMONER_1) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_1)
				end
			end
		end

		if GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
			if IreliaMenu.Combo.Ign:Value() and Ready(SUMMONER_2) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_2)
				end
			end
		end
	end
end

print("Travesti Irelia")















