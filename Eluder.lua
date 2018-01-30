--
-- ████████╗ ██████╗  ██╗    ███████╗███████╗██████╗ ██╗███████╗███████╗
-- ╚══██╔══╝██╔═████╗███║    ██╔════╝██╔════╝██╔══██╗██║██╔════╝██╔════╝
--    ██║   ██║██╔██║╚██║    ███████╗█████╗  ██████╔╝██║█████╗  ███████╗
--    ██║   ████╔╝██║ ██║    ╚════██║██╔══╝  ██╔══██╗██║██╔══╝  ╚════██║
--    ██║   ╚██████╔╝ ██║    ███████║███████╗██║  ██║██║███████╗███████║
--    ╚═╝    ╚═════╝  ╚═╝    ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
-- ==================
-- == Introduction ==
-- ==================
-- Current version: 1.0.4
-- Intermediate GoS script which supports currently 9 champions.
-- Features:
-- + supports Annie, Katarina, Syndra, Veigar, Viktor, Vladimir, Xerath, Yasuo, Zed
-- + contains special damage indicator​ over HP bar of enemy,
-- + uses offensive items while doing Combo,
-- + indludes table selection for Auto Level-up,
-- + 4 predictions to choose and current pos casting,
-- + additional features: Auto, Combo, Harass, KillSteal, LastHit,
--   LaneClear, JungleClear, Interrupter, Drawings, & Misc.
-- ==================
-- == Requirements ==
-- ==================
-- + Additional dangerous spells library for Vladimir: https://pastebin.com/raw/VKUhd6Fg
-- + Orbwalker: IOW/GosWalk
-- ===============
-- == Changelog ==
-- ===============
-- 1.0.4
-- + Added Zed
-- 1.0.3.1
-- + Improved Viktor's E logic & Xerath's R
-- 1.0.3
-- + Added Veigar
-- 1.0.2
-- + Added Annie
-- 1.0.1.2
-- + Removed OpenPredict from Syndra's W
-- 1.0.1.1
-- + Improved Syndra's Q+E
-- + Corrected delays
-- 1.0.1
-- + Added Syndra
-- 1.0
-- + Initial release
-- + Imported Katarina, Viktor, Vladimir, Xerath, Yasuo

require('Inspired')
require('IPrediction')
require('OpenPredict')

function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif GoSWalkLoaded and GoSWalk.CurrentMode then
		return ({"Combo", "Harass", "LaneClear", "LastHit"})[GoSWalk.CurrentMode+1]
	end
end

-- Annie

if "Annie" == GetObjectName(myHero) then

require('Interrupter')

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Annie loaded successfully!")
local AnnieMenu = Menu("[T01] Annie", "[T01] Annie")
AnnieMenu:Menu("Auto", "Auto")
AnnieMenu.Auto:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.Auto:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.Auto:Boolean('UseE', 'Use E [Molten Shield]', false)
AnnieMenu:Menu("Combo", "Combo")
AnnieMenu.Combo:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.Combo:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.Combo:Boolean('UseE', 'Use E [Molten Shield]', true)
AnnieMenu.Combo:Boolean('UseR', 'Use R [Summon Tibbers]', true)
AnnieMenu:Menu("Harass", "Harass")
AnnieMenu.Harass:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.Harass:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.Harass:Boolean('UseE', 'Use E [Molten Shield]', true)
AnnieMenu:Menu("KillSteal", "KillSteal")
AnnieMenu.KillSteal:Boolean('UseR', 'Use R [Summon Tibbers]', true)
AnnieMenu:Menu("LastHit", "LastHit")
AnnieMenu.LastHit:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu:Menu("LaneClear", "LaneClear")
AnnieMenu.LaneClear:Boolean('UseQ', 'Use Q [Disintegrate]', false)
AnnieMenu.LaneClear:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu:Menu("JungleClear", "JungleClear")
AnnieMenu.JungleClear:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.JungleClear:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.JungleClear:Boolean('UseE', 'Use E [Molten Shield]', true)
AnnieMenu:Menu("Interrupter", "Interrupter")
AnnieMenu.Interrupter:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.Interrupter:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu:Menu("Prediction", "Prediction")
AnnieMenu.Prediction:DropDown("PredictionW", "Prediction: W", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
AnnieMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
AnnieMenu:Menu("Drawings", "Drawings")
AnnieMenu.Drawings:Boolean('DrawQ', 'Draw Q Range', true)
AnnieMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
AnnieMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
AnnieMenu.Drawings:Boolean('DrawDMG', 'Draw Max QWR Damage', true)
AnnieMenu:Menu("Misc", "Misc")
AnnieMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
AnnieMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
AnnieMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
AnnieMenu.Misc:Slider('HP','HP-Manager: R', 25, 0, 100, 5)
AnnieMenu.Misc:Slider("MPQ","Mana-Manager: Q", 40, 0, 100, 5)
AnnieMenu.Misc:Slider("MPW","Mana-Manager: W", 40, 0, 100, 5)
AnnieMenu.Misc:Slider("MPE","Mana-Manager: E", 40, 0, 100, 5)

local AnnieQ = { range = 625 }
local AnnieW = { range = 600, angle = 50, radius = 50, width = 100, speed = math.huge, delay = 0.25, type = "cone", collision = false, source = myHero }
local AnnieR = { range = 600, radius = 290, width = 580, speed = math.huge, delay = 0.25, type = "circular", collision = false, source = myHero }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if AnnieMenu.Drawings.DrawQ:Value() then DrawCircle(pos,AnnieQ.range,1,25,0xff00bfff) end
if AnnieMenu.Drawings.DrawW:Value() then DrawCircle(pos,AnnieW.range,1,25,0xff4169e1) end
if AnnieMenu.Drawings.DrawR:Value() then DrawCircle(pos,AnnieR.range,1,25,0xff0000ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (35*GetCastLevel(myHero,_Q)+45)+(0.8*GetBonusAP(myHero))
	local WDmg = (45*GetCastLevel(myHero,_W)+25)+(0.85*GetBonusAP(myHero))
	local RDmg = (125*GetCastLevel(myHero,_R)+25)+(0.65*GetBonusAP(myHero))
	local ComboDmg = QDmg + WDmg + RDmg
	local WRDmg = WDmg + RDmg
	local QRDmg = QDmg + RDmg
	local QWDmg = QDmg + WDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if AnnieMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		KillSteal()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	if GetDistance(target) < AnnieW.range then
		if AnnieMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif AnnieMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),AnnieW.speed,AnnieW.delay*1000,AnnieW.range,AnnieW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif AnnieMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,AnnieW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif AnnieMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="Incinerate", range=AnnieW.range, speed=AnnieW.speed, delay=AnnieW.delay, width=AnnieW.width, type="conic", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(AnnieW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif AnnieMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetConicAOEPrediction(target,AnnieW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	CastSpell(_E)
end
function useR(target)
	if GetDistance(target) < AnnieR.range then
		if AnnieMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif AnnieMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),AnnieR.speed,AnnieR.delay*1000,AnnieR.range,AnnieR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif AnnieMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,AnnieR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif AnnieMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="InfernalGuardian", range=AnnieR.range, speed=AnnieR.speed, delay=AnnieR.delay, width=AnnieR.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(AnnieR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif AnnieMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetCircularAOEPrediction(target,AnnieR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Interrupter

addInterrupterCallback(function(target, spellType, spell)
	if AnnieMenu.Interrupter.UseQ:Value() then
		if ValidTarget(target, AnnieQ.range) then
			if CanUseSpell(myHero,_Q) == READY then
				if GotBuff(myHero, "pyromaniastun") > 0 then
					if spellType == GAPCLOSER_SPELLS or spellType == CHANELLING_SPELLS then
						useQ(target)
					end
				end
			end
		end
	end
	if AnnieMenu.Interrupter.UseW:Value() then
		if ValidTarget(target, AnnieW.range) then
			if CanUseSpell(myHero,_W) == READY then
				if GotBuff(myHero, "pyromaniastun") > 0 then
					if spellType == GAPCLOSER_SPELLS or spellType == CHANELLING_SPELLS then
						useW(target)
					end
				end
			end
		end
	end
end)

-- Auto

OnTick(function(myHero)
	if AnnieMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, AnnieQ.range) then
					useQ(target)
				end
			end
		end
	end
	if AnnieMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, AnnieW.range) then
					useW(target)
				end
			end
		end
	end
	if AnnieMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, 1000) then
					useE(target)
				end
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if AnnieMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, AnnieQ.range) then
					useQ(target)
				end
			end
		end
		if AnnieMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, AnnieW.range) then
					useE(target)
				end
			end
		end
		if AnnieMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, 1000) then
					useE(target)
				end
			end
		end
		if AnnieMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, AnnieR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < AnnieMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, AnnieR.range) >= AnnieMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if AnnieMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, AnnieQ.range) then
						useQ(target)
					end
				end
			end
		end
		if AnnieMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, AnnieW.range) then
						useW(target)
					end
				end
			end
		end
		if AnnieMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, 1000) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if AnnieMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, AnnieR.range) then
				if CanUseSpell(myHero,_R) == READY then
					if AlliesAround(myHero, 1000) == 0 then
						local AnnieRDmg = (125*GetCastLevel(myHero,_R)+25)+(0.65*GetBonusAP(myHero))
						if GetCurrentHP(enemy) < AnnieRDmg then
							useR(enemy)
						end
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, AnnieQ.range) then
					if AnnieMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local AnnieQDmg = (20*GetCastLevel(myHero,_Q)+60)+(0.6*GetBonusAP(myHero))
							if GetCurrentHP(minion) < AnnieQDmg then
								BlockInput(true)
								if _G.IOW then
									IOW.attacksEnabled = false
								elseif _G.GoSWalkLoaded then
									_G.GoSWalk:EnableAttack(false)
								end
								useQ(minion)
								BlockInput(false)
								if _G.IOW then
									IOW.attacksEnabled = true
								elseif _G.GoSWalkLoaded then
									_G.GoSWalk:EnableAttack(true)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if AnnieMenu.LaneClear.UseQ:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPQ:Value() then
						if ValidTarget(minion, AnnieQ.range) then
							if CanUseSpell(myHero,_Q) == READY then
								useQ(minion)
							end
						end
					end
				end
				if AnnieMenu.LaneClear.UseW:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Misc.MPW:Value() then
						if ValidTarget(minion, AnnieW.range) then
							if CanUseSpell(myHero,_W) == READY then
								if MinionsAround(myHero, AnnieW.range) >= 3 then
									CastSkillShot(_W,GetOrigin(minion))
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, AnnieQ.range) then
						if AnnieMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, AnnieW.range) then
						if AnnieMenu.JungleClear.UseW:Value() then
							useW(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, 500) then
						if AnnieMenu.JungleClear.UseE:Value() then
							useE(mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if AnnieMenu.Misc.AutoLvlUp:Value() then
		if AnnieMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

-- Katarina

elseif "Katarina" == GetObjectName(myHero) then

local Dagger = {}

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Katarina loaded successfully!")
local KatarinaMenu = Menu("[T01] Katarina", "[T01] Katarina")
KatarinaMenu:Menu("Auto", "Auto")
KatarinaMenu.Auto:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.Auto:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu:Menu("Combo", "Combo")
KatarinaMenu.Combo:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.Combo:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.Combo:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu.Combo:Boolean('UseR', 'Use R [Death Lotus]', true)
KatarinaMenu.Combo:Boolean('CD', 'Teleport To Diggers', true)
KatarinaMenu:Menu("Harass", "Harass")
KatarinaMenu.Harass:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.Harass:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.Harass:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu.Harass:Boolean('CD', 'Teleport To Diggers', true)
KatarinaMenu:Menu("KillSteal", "KillSteal")
KatarinaMenu.KillSteal:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu:Menu("LastHit", "LastHit")
KatarinaMenu.LastHit:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu:Menu("LaneClear", "LaneClear")
KatarinaMenu.LaneClear:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.LaneClear:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.LaneClear:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu:Menu("JungleClear", "JungleClear")
KatarinaMenu.JungleClear:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.JungleClear:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.JungleClear:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu:Menu("Prediction", "Prediction")
KatarinaMenu.Prediction:DropDown("PredictionE", "Prediction: E", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
KatarinaMenu:Menu("Drawings", "Drawings")
KatarinaMenu.Drawings:Boolean('DrawQ', 'Draw Q Range', true)
KatarinaMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
KatarinaMenu.Drawings:Boolean('DrawE', 'Draw E Range', true)
KatarinaMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
KatarinaMenu.Drawings:Boolean('DrawDMG', 'Draw Max QER Damage', true)
KatarinaMenu:Menu("Misc", "Misc")
KatarinaMenu.Misc:Boolean('UI', 'Use Items', true)
KatarinaMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
KatarinaMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 5, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
KatarinaMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
KatarinaMenu.Misc:Slider('HP','HP-Manager: R', 25, 0, 100, 5)

local KatarinaQ = { range = 625 }
local KatarinaW = { range = 340 }
local KatarinaE = { range = 725, radius = 100, width = 200, speed = math.huge, delay = 0.15, type = "circular", collision = false, source = myHero }
local KatarinaR = { range = 550 }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if KatarinaMenu.Drawings.DrawQ:Value() then DrawCircle(pos,KatarinaQ.range,1,25,0xff00bfff) end
if KatarinaMenu.Drawings.DrawW:Value() then DrawCircle(pos,KatarinaW.range,1,25,0xff4169e1) end
if KatarinaMenu.Drawings.DrawE:Value() then DrawCircle(pos,KatarinaE.range,1,25,0xff1e90ff) end
if KatarinaMenu.Drawings.DrawR:Value() then DrawCircle(pos,KatarinaR.range,1,25,0xff0000ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (30*GetCastLevel(myHero,_Q)+45)+(0.3*GetBonusAP(myHero))
	local EDmg = (15*GetCastLevel(myHero,_E))+(0.5*(GetBonusDmg(myHero)+GetBaseDamage(myHero)))+(0.25*GetBonusAP(myHero))
	local RDmg = (187.5*GetCastLevel(myHero,_R)+187.5)+(3.3*GetBonusDmg(myHero))+(2.85*GetBonusAP(myHero))
	local ComboDmg = QDmg + EDmg + RDmg
	local QRDmg = QDmg + RDmg
	local ERDmg = EDmg + RDmg
	local QEDmg = QDmg + EDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if KatarinaMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QEDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, EDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		KillSteal()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	CastSpell(_W)
end
function useE(target)
	if GetDistance(target) < KatarinaE.range then
		if KatarinaMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),KatarinaE.speed,KatarinaE.delay*1000,KatarinaE.range,KatarinaE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,KatarinaE,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="KatarinaE", range=KatarinaE.range, speed=KatarinaE.speed, delay=KatarinaE.delay, width=KatarinaE.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(KatarinaE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetCircularAOEPrediction(target,KatarinaE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end
function useECD(target)
	for _,Sztylet in pairs(Dagger) do
		if GetDistance(Sztylet, target) < KatarinaW.range then
			CastSkillShot(_E,GetOrigin(target) + (VectorWay(GetOrigin(target),GetOrigin(Sztylet))):normalized()*150)
		end
	end
end
function useR(target)
	if 100*GetCurrentHP(target)/GetMaxHP(target) < KatarinaMenu.Misc.HP:Value() then
		if EnemiesAround(myHero, KatarinaR.range) >= KatarinaMenu.Misc.X:Value() then
			CastSpell(_R)
		end
	end
end

OnTick(function(myHero)
	if GotBuff(myHero,"katarinarsound") > 0 then
		if EnemiesAround(myHero, KatarinaR.range) >= 1 then
			BlockF7OrbWalk(true)
			BlockF7Dodge(true)
			BlockInput(true)
			if _G.IOW then
				IOW.movementEnabled = false
				IOW.attacksEnabled = false
			elseif _G.GoSWalkLoaded then
				_G.GoSWalk:EnableMovement(false)
				_G.GoSWalk:EnableAttack(false)
			end
		else
			BlockF7OrbWalk(false)
			BlockF7Dodge(false)
			BlockInput(false)
			if _G.IOW then
				IOW.movementEnabled = true
				IOW.attacksEnabled = true
			elseif _G.GoSWalkLoaded then
				_G.GoSWalk:EnableMovement(true)
				_G.GoSWalk:EnableAttack(true)
			end
		end
	else
		BlockF7OrbWalk(false)
		BlockF7Dodge(false)
		BlockInput(false)
		if _G.IOW then
			IOW.movementEnabled = true
			IOW.attacksEnabled = true
		elseif _G.GoSWalkLoaded then
			_G.GoSWalk:EnableMovement(true)
			_G.GoSWalk:EnableAttack(true)
		end
	end
end)
OnSpellCast(function(_Q)
	if GotBuff(myHero,"katarinarsound") > 0 then
		BlockCast()
	end
end)
OnSpellCast(function(_W)
	if GotBuff(myHero,"katarinarsound") > 0 then
		BlockCast()
	end
end)
OnSpellCast(function(_E)
	if GotBuff(myHero,"katarinarsound") > 0 then
		BlockCast()
	end
end)

OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "HiddenMinion" then
		table.insert(Dagger, Object)
		DelayAction(function() table.remove(Dagger, 1) end, 4)
	end
end)
OnDeleteObj(function(Object)
	if GetObjectBaseName(Object) == "HiddenMinion" then
		for i,rip in pairs(Dagger) do
			if GetNetworkID(Object) == GetNetworkID(rip) then
				table.remove(Dagger,i) 
			end
		end
	end
end)
OnObjectLoad(function(Object)
	if GetObjectBaseName(Object) == "Katarina_Base_W_Indicator_Ally.troy" then
		Dagger = Object
	end
end)
OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "Katarina_Base_W_Indicator_Ally.troy" then
		Dagger = Object
	end
end)

-- Auto

OnTick(function(myHero)
	if KatarinaMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY then
			if ValidTarget(target, KatarinaQ.range) then
				useQ(target)
			end
		end
	end
	if KatarinaMenu.Auto.UseW:Value() then
		if CanUseSpell(myHero,_W) == READY then
			if ValidTarget(target, KatarinaW.range) then
				useW(target)
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if KatarinaMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, KatarinaQ.range) then
					useQ(target)
				end
			end
		end
		if KatarinaMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, KatarinaW.range) then
					useW(target)
				end
			end
		end
		if KatarinaMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, KatarinaE.range) then
					if KatarinaMenu.Combo.CD:Value() then
						useECD(target)
					else
						useE(target)
					end
				end
			end
		end
		if KatarinaMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, KatarinaR.range-350) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < KatarinaMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, KatarinaR.range) >= KatarinaMenu.Misc.X:Value() then
							useR(target)
							BlockF7OrbWalk(true)
							BlockF7Dodge(true)
							BlockInput(true)
							if _G.IOW then
								IOW.movementEnabled = false
								IOW.attacksEnabled = false
							elseif _G.GoSWalkLoaded then
								_G.GoSWalk:EnableMovement(false)
								_G.GoSWalk:EnableAttack(false)
							end
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if KatarinaMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, KatarinaQ.range) then
					useQ(target)
				end
			end
		end
		if KatarinaMenu.Harass.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, KatarinaW.range) then
					useW(target)
				end
			end
		end
		if KatarinaMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, KatarinaE.range) then
					if KatarinaMenu.Harass.CD:Value() then
						useECD(target)
					else
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if KatarinaMenu.KillSteal.UseE:Value() then
			if ValidTarget(enemy, KatarinaE.range) then
				if CanUseSpell(myHero,_E) == READY then
					local KatarinaEDmg = (15*GetCastLevel(myHero,_E))+(0.5*(GetBonusDmg(myHero)+GetBaseDamage(myHero)))+(0.25*GetBonusAP(myHero))
					if GetCurrentHP(enemy) < KatarinaEDmg then
						useE(enemy)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, KatarinaQ.range) then
					if KatarinaMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local KatarinaQDmg = (30*GetCastLevel(myHero,_Q)+45)+(0.3*GetBonusAP(myHero))
							if GetCurrentHP(minion) < KatarinaQDmg then
								useQ(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if KatarinaMenu.LaneClear.UseQ:Value() then
					if ValidTarget(minion, KatarinaQ.range) then
						if KatarinaMenu.LaneClear.UseQ:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								useQ(minion)
							end
						end
					end
				end
				if KatarinaMenu.LaneClear.UseW:Value() then
					if ValidTarget(minion, KatarinaW.range) then
						if KatarinaMenu.LaneClear.UseW:Value() then
							if CanUseSpell(myHero,_W) == READY then
								useW(minion)
							end
						end
					end
				end
				if KatarinaMenu.LaneClear.UseE:Value() then
					if ValidTarget(minion, KatarinaE.range) then
						if KatarinaMenu.LaneClear.UseE:Value() then
							if CanUseSpell(myHero,_E) == READY then
								CastSkillShot(_E,GetOrigin(minion))
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, KatarinaQ.range) then
						if KatarinaMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, KatarinaW.range) then
						if KatarinaMenu.JungleClear.UseW:Value() then
							useW(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, KatarinaE.range) then
						if KatarinaMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E,GetOrigin(minion))
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if KatarinaMenu.Misc.UI:Value() then
			local target = GetCurrentTarget()
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

OnTick(function(myHero)
	if KatarinaMenu.Misc.AutoLvlUp:Value() then
		if KatarinaMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

function VectorWay(A,B)
	WayX = B.x - A.x
	WayY = B.y - A.y
	WayZ = B.z - A.z
	return Vector(WayX, WayY, WayZ)
end

-- Syndra

elseif "Syndra" == GetObjectName(myHero) then

local Seed = {}

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Syndra loaded successfully!")
local SyndraMenu = Menu("[T01] Syndra", "[T01] Syndra")
SyndraMenu:Menu("Auto", "Auto")
SyndraMenu.Auto:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.Auto:Boolean('UseW', 'Use W [Force of Will]', false)
SyndraMenu.Auto:Boolean('UseE', 'Use E [Scatter the Weak]', false)
SyndraMenu:Menu("Combo", "Combo")
SyndraMenu.Combo:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.Combo:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu.Combo:Boolean('UseE', 'Use E [Scatter the Weak]', true)
SyndraMenu.Combo:Boolean('UseQE', 'Use Stunning Q+E', true)
SyndraMenu:Menu("Harass", "Harass")
SyndraMenu.Harass:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.Harass:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu.Harass:Boolean('UseE', 'Use E [Scatter the Weak]', false)
SyndraMenu:Menu("KillSteal", "KillSteal")
SyndraMenu.KillSteal:Boolean('UseR', 'Use R [Unleashed Power]', true)
SyndraMenu:Menu("LaneClear", "LaneClear")
SyndraMenu.LaneClear:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.LaneClear:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu:Menu("JungleClear", "JungleClear")
SyndraMenu.JungleClear:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.JungleClear:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu.JungleClear:Boolean('UseE', 'Use E [Scatter the Weak]', true)
SyndraMenu:Menu("Prediction", "Prediction")
SyndraMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
SyndraMenu.Prediction:DropDown("PredictionW", "Prediction: W", 1, {"CurrentPos", "GoSPred"})
SyndraMenu.Prediction:DropDown("PredictionE", "Prediction: E", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
SyndraMenu:Menu("Drawings", "Drawings")
SyndraMenu.Drawings:Boolean('DrawQ', 'Draw Q Range', true)
SyndraMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
SyndraMenu.Drawings:Boolean('DrawE', 'Draw E Range', true)
SyndraMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
SyndraMenu.Drawings:Boolean('DrawDMG', 'Draw Max QWER Damage', true)
SyndraMenu:Menu("Misc", "Misc")
SyndraMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
SyndraMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
SyndraMenu.Misc:Slider("MPQ","Mana-Manager: Q", 40, 0, 100, 5)
SyndraMenu.Misc:Slider("MPW","Mana-Manager: W", 40, 0, 100, 5)
SyndraMenu.Misc:Slider("MPE","Mana-Manager: E", 40, 0, 100, 5)

function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif _G.PW_Loaded and PW:Mode() then
		return PW:Mode()
	elseif _G.DAC_Loaded and DAC:Mode() then
		return DAC:Mode()
	elseif _G.AutoCarry_Loaded and DACR:Mode() then
		return DACR:Mode()
	elseif _G.SLW_Loaded and SLW:Mode() then
		return SLW:Mode()
	elseif GoSWalkLoaded and GoSWalk.CurrentMode then
		return ({"Combo", "Harass", "LaneClear", "LastHit"})[GoSWalk.CurrentMode+1]
	end
end

-- Syndra

local SyndraQ = { range = 800, radius = 150, width = 300, speed = math.huge, delay = 0.6, type = "circular", collision = false, source = myHero }
local SyndraW = { range = 950, radius = 225, width = 450, speed = 1450, delay = 0.25, type = "circular", collision = false, source = myHero }
local SyndraE = { range = 700, angle = 40, radius = 40, width = 80, speed = 2500, delay = 0.25, type = "cone", collision = false, source = myHero }
local SyndraR = { range = GetCastRange(myHero,_R) }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if SyndraMenu.Drawings.DrawQ:Value() then DrawCircle(pos,SyndraQ.range,1,25,0xff00bfff) end
if SyndraMenu.Drawings.DrawW:Value() then DrawCircle(pos,SyndraW.range,1,25,0xff4169e1) end
if SyndraMenu.Drawings.DrawE:Value() then DrawCircle(pos,SyndraE.range,1,25,0xff1e90ff) end
if SyndraMenu.Drawings.DrawR:Value() then DrawCircle(pos,SyndraR.range,1,25,0xff0000ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (45*GetCastLevel(myHero,_Q)+5)+(0.65*GetBonusAP(myHero))
	local WDmg = (40*GetCastLevel(myHero,_W)+30)+(0.7*GetBonusAP(myHero))
	local EDmg = (45*GetCastLevel(myHero,_E)+25)+(0.6*GetBonusAP(myHero))
	local RDmg = (315*GetCastLevel(myHero,_R)+315)+(1.4*GetBonusAP(myHero))
	local ComboDmg = QDmg + WDmg + EDmg + RDmg
	local WERDmg = WDmg + EDmg + RDmg
	local QERDmg = QDmg + EDmg + RDmg
	local QWRDmg = QDmg + WDmg + RDmg
	local QWEDmg = QDmg + WDmg + EDmg
	local ERDmg = EDmg + RDmg
	local WRDmg = WDmg + RDmg
	local QRDmg = QDmg + RDmg
	local WEDmg = WDmg + EDmg
	local QEDmg = QDmg + EDmg
	local QWDmg = QDmg + WDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if SyndraMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_W) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_W) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWEDmg), 0xff008080)
				elseif Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ERDmg), 0xff008080)
				elseif Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_W) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WEDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QEDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WDmg), 0xff008080)
				elseif Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, EDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		KillSteal()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	if GetDistance(target) < SyndraQ.range then
		if SyndraMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),SyndraQ.speed,SyndraQ.delay*1000,SyndraQ.range,SyndraQ.width,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 3 then
			local QPred = _G.gPred:GetPrediction(target,myHero,SyndraQ,true,false)
			if QPred and QPred.HitChance >= 3 then
				CastSkillShot(_Q, QPred.CastPosition)
			end
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="SyndraQ", range=SyndraQ.range, speed=SyndraQ.speed, delay=SyndraQ.delay, width=SyndraQ.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(SyndraQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetCircularAOEPrediction(target,SyndraQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	if GetDistance(target) < SyndraW.range then
		if SyndraMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot3(_W,target,GetOrigin(Seed))
		elseif SyndraMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),SyndraW.speed,SyndraW.delay*1000,SyndraW.range,SyndraW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot3(_W, WPred.PredPos, GetOrigin(Seed))
			end
		end
	end
end
function useE(target)
	if GetDistance(target) < SyndraE.range then
		if SyndraMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif SyndraMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),SyndraE.speed,SyndraE.delay*1000,SyndraE.range,SyndraE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif SyndraMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,SyndraE,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif SyndraMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="SyndraE", range=SyndraE.range, speed=SyndraE.speed, delay=SyndraE.delay, width=SyndraE.width, type="conic", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(SyndraE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif SyndraMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetConicAOEPrediction(target,SyndraE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end

local function CountBalls(table)
	local count = 0
	for _ in pairs(table) do 
		count = count + 1 
	end
	return count
end
OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "Missile" then
		table.insert(Seed, Object)
		DelayAction(function() table.remove(Seed, 1) end, 6)
	end
end)
OnDeleteObj(function(Object)
	if GetObjectBaseName(Object) == "Missile" then
		for i,rip in pairs(Seed) do
			if GetNetworkID(Object) == GetNetworkID(rip) then
				table.remove(Seed,i)
			end
		end
	end
end)
OnObjectLoad(function(Object)
	if GetObjectBaseName(Object) == "Seed" then
		Seed = Object
	end
end)
OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "Seed" then
		Seed = Object
	end
end)

-- Auto

OnTick(function(myHero)
	if SyndraMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, SyndraQ.range) then
					useQ(target)
				end
			end
		end
	end
	if SyndraMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, SyndraW.range) then
					useW(target)
				end
			end
		end
	end
	if SyndraMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, SyndraE.range) then
					useE(target)
				end
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if SyndraMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, SyndraQ.range) then
					useQ(target)
				end
			end
		end
		if SyndraMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, SyndraW.range) then
					useW(target)
				end
			end
		end
		if SyndraMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, SyndraE.range) then
					useE(target)
				end
			end
		end
		if SyndraMenu.Combo.UseQE:Value() then
			if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, 1250) then
					local QPos = Vector(myHero)-500*(Vector(myHero)-Vector(target)):normalized()
					CastSkillShot(_Q, QPos)
					DelayAction(function() CastSkillShot(_E, QPos) end, 0.25)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if SyndraMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, SyndraQ.range) then
						useQ(target)
					end
				end
			end
		end
		if SyndraMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, SyndraW.range) then
						useW(target)
					end
				end
			end
		end
		if SyndraMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, SyndraE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if SyndraMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, SyndraR.range) then
				if CanUseSpell(myHero,_R) == READY then
					local RMulti = CountBalls(Seed) < 0 and 3 or CountBalls(Seed) > 0 and 3 + CountBalls(Seed) or 3
					local SyndraRDmg = ((45*GetCastLevel(myHero,_R)+45)+(0.2*GetBonusAP(myHero)))*RMulti
					if GetCurrentHP(enemy) < SyndraRDmg then
						CastTargetSpell(enemy, _R)
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if SyndraMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					local BestPos, BestHit = GetFarmPosition(SyndraQ.range, SyndraQ.radius)
					if BestPos and BestHit > 2 then
						CastSkillShot(_Q, BestPos)
					end
				end
			end
		end
		if SyndraMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetFarmPosition(SyndraW.range, SyndraW.radius)
					if BestPos and BestHit > 2 then 
						CastSkillShot3(_W, BestPos, GetOrigin(Seed))
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, SyndraQ.range) then
						if SyndraMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q, mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, SyndraW.range) then
						if SyndraMenu.JungleClear.UseW:Value() then
							CastSkillShot3(_W, mob, GetOrigin(Seed))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, SyndraE.range) then
						if SyndraMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E, mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if SyndraMenu.Misc.AutoLvlUp:Value() then
		if SyndraMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

function VectorWay(A,B)
	WayX = B.x - A.x
	WayY = B.y - A.y
	WayZ = B.z - A.z
	return Vector(WayX, WayY, WayZ)
end

-- Veigar

elseif "Veigar" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Veigar loaded successfully!")
local VeigarMenu = Menu("[T01] Veigar", "[T01] Veigar")
VeigarMenu:Menu("Auto", "Auto")
VeigarMenu.Auto:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.Auto:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu.Auto:Boolean('UseE', 'Use E [Event Horizon]', true)
VeigarMenu.Auto:DropDown("ModeW", "Cast Mode: W", 2, {"On Dashing", "On Stunned"})
VeigarMenu:Menu("Combo", "Combo")
VeigarMenu.Combo:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.Combo:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu.Combo:Boolean('UseE', 'Use E [Event Horizon]', true)
VeigarMenu.Combo:DropDown("ModeW", "Cast Mode: W", 1, {"On Dashing", "On Stunned"})
VeigarMenu:Menu("Harass", "Harass")
VeigarMenu.Harass:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.Harass:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu.Harass:Boolean('UseE', 'Use E [Event Horizon]', true)
VeigarMenu.Harass:DropDown("ModeW", "Cast Mode: W", 2, {"On Dashing", "On Stunned"})
VeigarMenu:Menu("KillSteal", "KillSteal")
VeigarMenu.KillSteal:Boolean('UseR', 'Use R [Primordial Burst]', true)
VeigarMenu:Menu("LastHit", "LastHit")
VeigarMenu.LastHit:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu:Menu("LaneClear", "LaneClear")
VeigarMenu.LaneClear:Boolean('UseQ', 'Use Q [Baleful Strike]', false)
VeigarMenu.LaneClear:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu:Menu("JungleClear", "JungleClear")
VeigarMenu.JungleClear:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.JungleClear:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu:Menu("Prediction", "Prediction")
VeigarMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 3, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VeigarMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VeigarMenu.Prediction:DropDown("PredictionE", "Prediction: E", 1, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VeigarMenu:Menu("Drawings", "Drawings")
VeigarMenu.Drawings:Boolean('DrawQ', 'Draw Q Range', true)
VeigarMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
VeigarMenu.Drawings:Boolean('DrawE', 'Draw E Range', true)
VeigarMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
VeigarMenu.Drawings:Boolean('DrawDMG', 'Draw Max QWR Damage', true)
VeigarMenu:Menu("Misc", "Misc")
VeigarMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
VeigarMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
VeigarMenu.Misc:Slider("MPQ","Mana-Manager: Q", 40, 0, 100, 5)
VeigarMenu.Misc:Slider("MPW","Mana-Manager: W", 40, 0, 100, 5)
VeigarMenu.Misc:Slider("MPE","Mana-Manager: E", 40, 0, 100, 5)

local VeigarQ = { range = 950, radius = 70, width = 140, speed = 2000, delay = 0.25, type = "line", collision = true, source = myHero }
local VeigarW = { range = 900, radius = 250, width = 500, speed = math.huge, delay = 1.25, type = "circular", collision = false, source = myHero }
local VeigarE = { range = 700, radius = 375, width = 750, speed = math.huge, delay = 0.5, type = "circular", collision = false, source = myHero }
local VeigarR = { range = 650 }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if VeigarMenu.Drawings.DrawQ:Value() then DrawCircle(pos,VeigarQ.range,1,25,0xff00bfff) end
if VeigarMenu.Drawings.DrawW:Value() then DrawCircle(pos,VeigarW.range,1,25,0xff4169e1) end
if VeigarMenu.Drawings.DrawE:Value() then DrawCircle(pos,VeigarE.range,1,25,0xff1e90ff) end
if VeigarMenu.Drawings.DrawR:Value() then DrawCircle(pos,VeigarR.range,1,25,0xff0000ff) end
end)

function getMin(x, y)
	if x<y then
		return x
	end
	return y
end
OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (40*GetCastLevel(myHero,_Q)+30)+(0.6*GetBonusAP(myHero))
	local WDmg = (50*GetCastLevel(myHero,_W)+50)+(GetBonusAP(myHero))
	local RDmg = (75*GetCastLevel(myHero,_R)+100)+(0.75*GetBonusAP(myHero))+getMin(2,-1/67*((GetCurrentHP(target)/GetMaxHP(target))*100)+2.49)
	local ComboDmg = QDmg + WDmg + RDmg
	local WRDmg = WDmg + RDmg
	local QRDmg = QDmg + RDmg
	local QWDmg = QDmg + WDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if VeigarMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		KillSteal()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	if GetDistance(target) < VeigarQ.range then
		if VeigarMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VeigarQ.speed,VeigarQ.delay*1000,VeigarQ.range,VeigarQ.radius,true,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,VeigarQ,true,true)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="VeigarBalefulStrike", range=VeigarQ.range, speed=VeigarQ.speed, delay=VeigarQ.delay, width=VeigarQ.radius, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(VeigarQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,VeigarQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	if GetDistance(target) < VeigarW.range then
		if VeigarMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif VeigarMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VeigarW.speed,VeigarW.delay*1000,VeigarW.range,VeigarW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif VeigarMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,VeigarW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif VeigarMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="VeigarDarkMatter", range=VeigarW.range, speed=VeigarW.speed, delay=VeigarW.delay, width=VeigarW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(VeigarW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif VeigarMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,VeigarW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useWIM(target)
	CastSkillShot(_W,GetOrigin(target))
end
function useE(target)
	if GetDistance(target) < VeigarE.range then
		if VeigarMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif VeigarMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VeigarE.speed,VeigarE.delay*1000,VeigarE.range,VeigarE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif VeigarMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,VeigarE,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif VeigarMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="VeigarEventHorizon", range=VeigarE.range, speed=VeigarE.speed, delay=VeigarE.delay, width=VeigarE.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(VeigarE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif VeigarMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetConicAOEPrediction(target,VeigarE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end

-- Auto

OnTick(function(myHero)
	if VeigarMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VeigarQ.range) then
					useQ(target)
				end
			end
		end
	end
	if VeigarMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, VeigarW.range) then
					if VeigarMenu.Auto.ModeW:Value() == 1 then
						useW(target)
					elseif VeigarMenu.Auto.ModeW:Value() == 2 then
						if GotBuff(target, "veigareventhorizonstun") > 0 then
							useWIM(target)
						end
					end
				end
			end
		end
	end
	if VeigarMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VeigarE.range) then
					useE(target)
				end
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if VeigarMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VeigarQ.range) then
					useQ(target)
				end
			end
		end
		if VeigarMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, VeigarW.range) then
					if VeigarMenu.Combo.ModeW:Value() == 1 then
						useW(target)
					elseif VeigarMenu.Combo.ModeW:Value() == 2 then
						if GotBuff(target, "veigareventhorizonstun") > 0 then
							useWIM(target)
						end
					end
				end
			end
		end
		if VeigarMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VeigarE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if VeigarMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, VeigarQ.range) then
						useQ(target)
					end
				end
			end
		end
		if VeigarMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, VeigarW.range) then
						if VeigarMenu.Harass.ModeW:Value() == 1 then
							useW(target)
						elseif VeigarMenu.Harass.ModeW:Value() == 2 then
							if GotBuff(target, "veigareventhorizonstun") > 0 then
								useWIM(target)
							end
						end
					end
				end
			end
		end
		if VeigarMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, VeigarE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if VeigarMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, VeigarR.range) then
				if CanUseSpell(myHero,_R) == READY then
					local VeigarRDmg = (75*GetCastLevel(myHero,_R)+100)+(0.75*GetBonusAP(myHero))+getMin(2,-1/67*((GetCurrentHP(enemy)/GetMaxHP(enemy))*100)+2.49)
					if GetCurrentHP(enemy) < VeigarRDmg then
						CastTargetSpell(enemy, _R)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, VeigarQ.range) then
					if VeigarMenu.LastHit.UseQ:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPQ:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								local VeigarQDmg = (40*GetCastLevel(myHero,_Q)+30)+(0.6*GetBonusAP(myHero))
								if GetCurrentHP(minion) < VeigarQDmg then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if VeigarMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetLineFarmPosition(VeigarW.range, VeigarW.radius)
					if BestPos and BestHit > 2 then  
						CastSkillShot(_W, BestPos)
					end
				end
			end
		end
		if VeigarMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Misc.MPQ:Value() then
				for _, minion in pairs(minionManager.objects) do
					if GetTeam(minion) == MINION_ENEMY then
						if ValidTarget(minion, VeigarQ.range) then
							if VeigarMenu.LaneClear.UseQ:Value() then
								if CanUseSpell(myHero,_Q) == READY then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, VeigarQ.range) then
						if VeigarMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, VeigarW.range) then
						if VeigarMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if VeigarMenu.Misc.AutoLvlUp:Value() then
		if VeigarMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

-- Viktor

elseif "Viktor" == GetObjectName(myHero) then

require('Interrupter')

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Viktor loaded successfully!")
local ViktorMenu = Menu("[T01] Viktor", "[T01] Viktor")
ViktorMenu:Menu("Auto", "Auto")
ViktorMenu.Auto:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.Auto:Boolean('UseW', 'Use W [Gravity Field]', false)
ViktorMenu.Auto:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu:Menu("Combo", "Combo")
ViktorMenu.Combo:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.Combo:Boolean('UseW', 'Use W [Gravity Field]', true)
ViktorMenu.Combo:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu.Combo:Boolean('UseR', 'Use R [Chaos Storm]', true)
ViktorMenu:Menu("Harass", "Harass")
ViktorMenu.Harass:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.Harass:Boolean('UseW', 'Use W [Gravity Field]', true)
ViktorMenu.Harass:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu:Menu("LastHit", "LastHit")
ViktorMenu.LastHit:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu:Menu("LaneClear", "LaneClear")
ViktorMenu.LaneClear:Boolean('UseQ', 'Use Q [Siphon Power]', false)
ViktorMenu.LaneClear:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu:Menu("JungleClear", "JungleClear")
ViktorMenu.JungleClear:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.JungleClear:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu:Menu("Interrupter", "Interrupter")
ViktorMenu.Interrupter:Boolean('UseW', 'Use W [Gravity Field]', true)
ViktorMenu.Interrupter:Boolean('UseR', 'Use R [Chaos Storm]', true)
ViktorMenu:Menu("Prediction", "Prediction")
ViktorMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
ViktorMenu.Prediction:DropDown("PredictionE", "Prediction: E", 2, {"CurrentPos", "GoSPred", "OpenPredict"})
ViktorMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
ViktorMenu:Menu("Drawings", "Drawings")
ViktorMenu.Drawings:Boolean('DrawQ', 'Draw Q Range', true)
ViktorMenu.Drawings:Boolean('DrawWR', 'Draw WR Range', true)
ViktorMenu.Drawings:Boolean('DrawE', 'Draw E Range', true)
ViktorMenu.Drawings:Boolean('DrawDMG', 'Draw Max QWER Damage', true)
ViktorMenu:Menu("Misc", "Misc")
ViktorMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
ViktorMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 5, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
ViktorMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
ViktorMenu.Misc:Slider('HP','HP-Manager: R', 25, 0, 100, 5)
ViktorMenu.Misc:Slider("MPQ","Mana-Manager: Q", 40, 0, 100, 5)
ViktorMenu.Misc:Slider("MPW","Mana-Manager: W", 40, 0, 100, 5)
ViktorMenu.Misc:Slider("MPE","Mana-Manager: E", 40, 0, 100, 5)

local ViktorQ = { range = 600 }
local ViktorW = { range = 700, radius = 300, width = 600, speed = math.huge, delay = 0.25, type = "circular", collision = false, source = myHero }
local ViktorE = { range = 1025, radius = 80, width = 160, speed = 1350, delay = 0, type = "line", collision = false, source = myHero }
local ViktorR = { range = 700, radius = 300, width = 600, speed = math.huge, delay = 0.25, type = "circular", collision = false, source = myHero }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if ViktorMenu.Drawings.DrawQ:Value() then DrawCircle(pos,ViktorQ.range,1,25,0xff00bfff) end
if ViktorMenu.Drawings.DrawWR:Value() then DrawCircle(pos,ViktorW.range,1,25,0xff0000ff) end
if ViktorMenu.Drawings.DrawE:Value() then DrawCircle(pos,ViktorE.range,1,25,0xff1e90ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = ((20*GetCastLevel(myHero,_Q)+40)+(0.4*GetBonusAP(myHero)))+((20*GetCastLevel(myHero,_Q))+(GetBonusDmg(myHero)+GetBaseDamage(myHero))+(0.5*GetBonusAP(myHero)))
	local EDmg = (60*GetCastLevel(myHero,_E)+30)+(1.2*GetBonusAP(myHero))
	local RDmg = (375*GetCastLevel(myHero,_R)+175)+(2.3*GetBonusAP(myHero))
	local ComboDmg = QDmg + EDmg + RDmg
	local QRDmg = QDmg + RDmg
	local ERDmg = EDmg + RDmg
	local QEDmg = QDmg + EDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if ViktorMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QEDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, EDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	BlockInput(true)
	if _G.IOW then
		IOW.attacksEnabled = false
	elseif _G.GoSWalkLoaded then
		_G.GoSWalk:EnableAttack(false)
	end
	CastTargetSpell(target, _Q)
	AttackUnit(target)
	BlockInput(false)
	if _G.IOW then
		IOW.attacksEnabled = true
	elseif _G.GoSWalkLoaded then
		_G.GoSWalk:EnableAttack(true)
	end
end
function useW(target)
	if GetDistance(target) < ViktorW.range then
		if ViktorMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif ViktorMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ViktorW.speed,ViktorW.delay*1000,ViktorW.range,ViktorW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif ViktorMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,ViktorW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif ViktorMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="ViktorGravitonField", range=ViktorW.range, speed=ViktorW.speed, delay=ViktorW.delay, width=ViktorW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(ViktorW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif ViktorMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,ViktorW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	if GetDistance(target) < ViktorE.range then
		if ViktorMenu.Prediction.PredictionE:Value() == 1 then
			local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(target)):normalized()
			CastSkillShot3(_E,StartPos,target)
		elseif ViktorMenu.Prediction.PredictionE:Value() == 2 then
			local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(target)):normalized()
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ViktorE.speed,ViktorE.delay*1000,ViktorE.range,ViktorE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot3(_E,StartPos,EPred.PredPos)
			end
		elseif ViktorMenu.Prediction.PredictionE:Value() == 3 then
			local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(target)):normalized()
			local EPrediction = GetLinearAOEPrediction(target,ViktorE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot3(_E,StartPos,EPrediction.castPos)
			end
		end
	end
end
function useR(target)
	if GetDistance(target) < ViktorR.range then
		if ViktorMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif ViktorMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ViktorR.speed,ViktorR.delay*1000,ViktorR.range,ViktorR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif ViktorMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,ViktorR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif ViktorMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="ViktorChaosStorm", range=ViktorR.range, speed=ViktorR.speed, delay=ViktorR.delay, width=ViktorR.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(ViktorR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif ViktorMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetCircularAOEPrediction(target,ViktorR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Interrupter

addInterrupterCallback(function(target, spellType, spell)
	if ViktorMenu.Interrupter.UseW:Value() then
		if ValidTarget(target, ViktorW.range) then
			if CanUseSpell(myHero,_W) == READY then
				if spellType == GAPCLOSER_SPELLS or spellType == CHANELLING_SPELLS then
					useW(target)
				end
			end
		end
	end
	if ViktorMenu.Interrupter.UseR:Value() then
		if ValidTarget(target, ViktorR.range) then
			if CanUseSpell(myHero,_R) == READY and spellType == CHANELLING_SPELLS then
				useR(target)
			end
		end
	end
end)

-- Auto

OnTick(function(myHero)
	if ViktorMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ViktorQ.range) then
					useQ(target)
				end
			end
		end
	end
	if ViktorMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, ViktorW.range) then
					useW(target)
				end
			end
		end
	end
	if ViktorMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ViktorE.range) then
					useE(target)
				end
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if ViktorMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ViktorQ.range) then
					useQ(target)
				end
			end
		end
		if ViktorMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, ViktorW.range) then
					useW(target)
				end
			end
		end
		if ViktorMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ViktorE.range) then
					useE(target)
				end
			end
		end
		if ViktorMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, ViktorR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < ViktorMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, ViktorR.range) >= ViktorMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if ViktorMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, ViktorQ.range) then
						useQ(target)
					end
				end
			end
		end
		if ViktorMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, ViktorW.range) then
						useW(target)
					end
				end
			end
		end
		if ViktorMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, ViktorE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, ViktorQ.range) then
					if ViktorMenu.LastHit.UseQ:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPQ:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								local ViktorQDmg = ((20*GetCastLevel(myHero,_Q)+40)+(0.4*GetBonusAP(myHero)))+((20*GetCastLevel(myHero,_Q))+(GetBonusDmg(myHero)+GetBaseDamage(myHero))+(0.5*GetBonusAP(myHero)))
								local MinionToLastHit = minion
								if GetCurrentHP(MinionToLastHit) < ViktorQDmg then
									useQ(MinionToLastHit)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if ViktorMenu.LaneClear.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					local BestPos, BestHit = GetLineFarmPosition(ViktorE.range, ViktorE.radius)
					if BestPos and BestHit > 2 then
						local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(BestPos)):normalized()
						CastSkillShot3(_E,StartPos,BestPos)
					end
				end
			end
		end
		if ViktorMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Misc.MPQ:Value() then
				for _, minion in pairs(minionManager.objects) do
					if GetTeam(minion) == MINION_ENEMY then
						if ValidTarget(minion, ViktorQ.range) then
							if ViktorMenu.LaneClear.UseQ:Value() then
								if CanUseSpell(myHero,_Q) == READY then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, ViktorQ.range) then
						if ViktorMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, ViktorE.range) then
						if ViktorMenu.JungleClear.UseE:Value() then
							StartPos = Vector(myHero)-ViktorE.range*(Vector(myHero)-Vector(mob)):normalized()		   
							CastSkillShot3(_E, StartPos, mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if ViktorMenu.Misc.AutoLvlUp:Value() then
		if ViktorMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

-- Vladimir

elseif "Vladimir" == GetObjectName(myHero) then

if not pcall( require, "AntiDangerousSpells" ) then PrintChat("<font color='#00BFFF'>You are missing AntiDangerousSpells custom addon: https://pastebin.com/raw/VKUhd6Fg") return end

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Vladimir loaded successfully!")
local VladimirMenu = Menu("[T01] Vladimir", "[T01] Vladimir")
VladimirMenu:Menu("Auto", "Auto")
VladimirMenu.Auto:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.Auto:Boolean('UseW', 'Use W [Sanguine Pool]', true)
VladimirMenu.Auto:Boolean('UseE', 'Use E [Tides of Blood]', false)
VladimirMenu:Menu("Combo", "Combo")
VladimirMenu.Combo:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.Combo:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu.Combo:Boolean('UseR', 'Use R [Hemoplague]', true)
VladimirMenu:Menu("Harass", "Harass")
VladimirMenu.Harass:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.Harass:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu:Menu("KillSteal", "KillSteal")
VladimirMenu.KillSteal:Boolean('UseR', 'Use R [Hemoplague]', true)
VladimirMenu:Menu("LastHit", "LastHit")
VladimirMenu.LastHit:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu:Menu("LaneClear", "LaneClear")
VladimirMenu.LaneClear:Boolean('UseQ', 'Use Q [Transfusion]', false)
VladimirMenu.LaneClear:Boolean('UseW', 'Use W [Sanguine Pool]', false)
VladimirMenu.LaneClear:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu:Menu("JungleClear", "JungleClear")
VladimirMenu.JungleClear:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.JungleClear:Boolean('UseW', 'Use W [Sanguine Pool]', true)
VladimirMenu.JungleClear:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu:Menu("Prediction", "Prediction")
VladimirMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VladimirMenu:Menu("Drawings", "Drawings")
VladimirMenu.Drawings:Boolean('DrawQE', 'Draw QE Range', true)
VladimirMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
VladimirMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
VladimirMenu.Drawings:Boolean('DrawDMG', 'Draw Max QWER Damage', true)
VladimirMenu:Menu("Misc", "Misc")
VladimirMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
VladimirMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
VladimirMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
VladimirMenu.Misc:Slider('HP','HP-Manager: R', 25, 0, 100, 5)

local VladimirQ = { range = 600 }
local VladimirW = { range = 300 }
local VladimirE = { range = 600 }
local VladimirR = { range = 700, radius = 175, width = 350, speed = math.huge, delay = 0.25, type = "circular", collision = false, source = myHero }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if VladimirMenu.Drawings.DrawQE:Value() then DrawCircle(pos,VladimirQ.range,1,25,0xff00bfff) end
if VladimirMenu.Drawings.DrawW:Value() then DrawCircle(pos,VladimirW.range,1,25,0xff4169e1) end
if VladimirMenu.Drawings.DrawR:Value() then DrawCircle(pos,VladimirR.range,1,25,0xff0000ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (20*GetCastLevel(myHero,_Q)+60)+(0.6*GetBonusAP(myHero))
	local WDmg = 55*GetCastLevel(myHero,_W)+25
	local EDmg = (30*GetCastLevel(myHero,_E)+30)+(0.06*GetMaxHP(myHero))+GetBonusAP(myHero)
	local RDmg = (100*GetCastLevel(myHero,_R)+50)+(0.7*GetBonusAP(myHero))
	local ComboDmg = QDmg + WDmg + EDmg + RDmg
	local WERDmg = WDmg + EDmg + RDmg
	local QERDmg = QDmg + EDmg + RDmg
	local QWRDmg = QDmg + WDmg + RDmg
	local QWEDmg = QDmg + WDmg + EDmg
	local ERDmg = EDmg + RDmg
	local WRDmg = WDmg + RDmg
	local QRDmg = QDmg + RDmg
	local WEDmg = WDmg + EDmg
	local QEDmg = QDmg + EDmg
	local QWDmg = QDmg + WDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if VladimirMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_W) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_W) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWEDmg), 0xff008080)
				elseif Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ERDmg), 0xff008080)
				elseif Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_W) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WEDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QEDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WDmg), 0xff008080)
				elseif Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, EDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		KillSteal()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	CastSpell(_W)
end
function useE(target)
	BlockInput(true)
	if _G.IOW then
		IOW.attacksEnabled = false
	elseif _G.GoSWalkLoaded then
		_G.GoSWalk:EnableAttack(false)
	end
	CastSkillShot(_E,GetOrigin(target))
end
OnTick(function(myHero)
	if GotBuff(myHero,"VladimirE") > 0 then
		BlockInput(true)
		if _G.IOW then
			IOW.attacksEnabled = false
		elseif _G.GoSWalkLoaded then
			_G.GoSWalk:EnableAttack(false)
		end
	else
		BlockInput(false)
		if _G.IOW then
			IOW.attacksEnabled = true
		elseif _G.GoSWalkLoaded then
			_G.GoSWalk:EnableAttack(true)
		end
	end
end)
function useR(target)
	if GetDistance(target) < VladimirR.range then
		if VladimirMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif VladimirMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VladimirR.speed,VladimirR.delay*1000,VladimirR.range,VladimirR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif VladimirMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,VladimirR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif VladimirMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="VladimirR", range=VladimirR.range, speed=VladimirR.speed, delay=VladimirR.delay, width=VladimirR.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(VladimirR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif VladimirMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetCircularAOEPrediction(target,VladimirR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Auto

OnTick(function(myHero)
	if VladimirMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY then
			if ValidTarget(target, VladimirQ.range) then
				useQ(target)
			end
		end
	end
	if VladimirMenu.Auto.UseE:Value() then
		if CanUseSpell(myHero,_E) == READY then
			if ValidTarget(target, VladimirE.range) then
				useE(target)
			end
		end
	end
end)
addAntiDSCallback(function()
	if VladimirMenu.Auto.UseW:Value() then
		if CanUseSpell(myHero,_W) == READY then
			CastSpell(_W)
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if VladimirMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VladimirQ.range) then
					useQ(target)
				end
			end
		end
		if VladimirMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VladimirE.range) then
					useE(target)
				end
			end
		end
		if VladimirMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, VladimirR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < VladimirMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, VladimirR.range) >= VladimirMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if VladimirMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VladimirQ.range) then
					useQ(target)
				end
			end
		end
		if VladimirMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VladimirE.range) then
					useE(target)
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if VladimirMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, VladimirR.range) then
				if CanUseSpell(myHero,_R) == READY then
					if AlliesAround(myHero, 1000) == 0 then
						local VladimirRDmg = (100*GetCastLevel(myHero,_R)+50)+(0.7*GetBonusAP(myHero))
						if GetCurrentHP(enemy) < VladimirRDmg then
							CastTargetSpell(enemy, _R)
						end
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, VladimirQ.range) then
					if VladimirMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local VladimirQDmg = (20*GetCastLevel(myHero,_Q)+60)+(0.6*GetBonusAP(myHero))
							if GotBuff(myHero, "vladimirqfrenzy") > 0 then
								if GetCurrentHP(minion) < VladimirQDmg*1.85 then
									useQ(minion)
								end
							else
								if GetCurrentHP(minion) < VladimirQDmg then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if VladimirMenu.LaneClear.UseQ:Value() then
					if ValidTarget(minion, VladimirQ.range) then
						if CanUseSpell(myHero,_Q) == READY then
							useQ(minion)
						end
					end
				end
				if VladimirMenu.LaneClear.UseW:Value() then
					if ValidTarget(minion, VladimirW.range) then
						if CanUseSpell(myHero,_W) == READY then
							if MinionsAround(myHero, VladimirW.range) >= 3 then
								useW(minion)
							end
						end
					end
				end
				if VladimirMenu.LaneClear.UseE:Value() then
					if ValidTarget(minion, VladimirE.range) then
						if CanUseSpell(myHero,_E) == READY then
							if MinionsAround(myHero, VladimirE.range) >= 3 then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, VladimirQ.range) then
						if VladimirMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, VladimirW.range) then
						if VladimirMenu.JungleClear.UseW:Value() then
							useW(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, VladimirE.range) then
						if VladimirMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if VladimirMenu.Misc.AutoLvlUp:Value() then
		if VladimirMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

-- Xerath

elseif "Xerath" == GetObjectName(myHero) then

require('Interrupter')

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Xerath loaded successfully!")
local XerathMenu = Menu("[T01] Xerath", "[T01] Xerath")
XerathMenu:Menu("Auto", "Auto")
XerathMenu.Auto:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.Auto:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu.Auto:Boolean('UseE', 'Use E [Shocking Orb]', false)
XerathMenu:Menu("Combo", "Combo")
XerathMenu.Combo:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.Combo:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu.Combo:Boolean('UseE', 'Use E [Shocking Orb]', true)
XerathMenu:Menu("Harass", "Harass")
XerathMenu.Harass:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.Harass:Boolean('UseW', 'Use W [Eye of Destruction]', false)
XerathMenu.Harass:Boolean('UseE', 'Use E [Shocking Orb]', false)
XerathMenu:Menu("KillSteal", "KillSteal")
XerathMenu.KillSteal:Boolean('UseR', 'Use R [Rite of the Arcane]', true)
XerathMenu:Menu("LastHit", "LastHit")
XerathMenu.LastHit:Boolean('UseE', 'Use E [Sweeping Blade]', true)
XerathMenu:Menu("LaneClear", "LaneClear")
XerathMenu.LaneClear:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.LaneClear:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu:Menu("JungleClear", "JungleClear")
XerathMenu.JungleClear:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.JungleClear:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu.JungleClear:Boolean('UseE', 'Use E [Shocking Orb]', true)
XerathMenu:Menu("Interrupter", "Interrupter")
XerathMenu.Interrupter:Boolean('UseE', 'Use E [Shocking Orb]', true)
XerathMenu:Menu("Prediction", "Prediction")
XerathMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu.Prediction:DropDown("PredictionE", "Prediction: E", 3, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu.Prediction:DropDown("PredictionR", "Prediction: R", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu:Menu("Drawings", "Drawings")
XerathMenu.Drawings:Boolean('DrawQ', 'Draw Q Range', true)
XerathMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
XerathMenu.Drawings:Boolean('DrawE', 'Draw E Range', true)
XerathMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
XerathMenu.Drawings:Boolean('DrawDMG', 'Draw Max QWER Damage', true)
XerathMenu:Menu("Misc", "Misc")
XerathMenu.Misc:Key("UseQ", "Casting Q Key", string.byte("A"))
XerathMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
XerathMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
XerathMenu.Misc:Boolean('ExtraDelay', 'Delay Before Casting Q', false)
XerathMenu.Misc:Slider("ED","Extended Delay: Q", 0.1, 0, 1, 0.05)
XerathMenu.Misc:Slider("MPQ","Mana-Manager: Q", 40, 0, 100, 5)
XerathMenu.Misc:Slider("MPW","Mana-Manager: W", 40, 0, 100, 5)
XerathMenu.Misc:Slider("MPE","Mana-Manager: E", 40, 0, 100, 5)

local XerathQ = { range = 1400, radius = 95, width = 190, speed = math.huge, delay = 0.5, type = "line", collision = false, source = myHero }
local XerathW = { range = 1100, radius = 200, width = 400, speed = math.huge, delay = 0.5, type = "circular", collision = false, source = myHero }
local XerathE = { range = 1050, radius = 60, width = 120, speed = 2300, delay = 0.2, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local XerathR = { range = GetCastRange(myHero,_R), radius = 130, width = 260, speed = math.huge, delay = 0.7, type = "circular", collision = false, source = myHero }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if XerathMenu.Drawings.DrawQ:Value() then DrawCircle(pos,XerathQ.range,1,25,0xff00bfff) end
if XerathMenu.Drawings.DrawW:Value() then DrawCircle(pos,XerathW.range,1,25,0xff4169e1) end
if XerathMenu.Drawings.DrawE:Value() then DrawCircle(pos,XerathE.range,1,25,0xff1e90ff) end
if XerathMenu.Drawings.DrawR:Value() then DrawCircle(pos,XerathR.range,1,25,0xff0000ff) end
end)
OnDrawMinimap(function()
local pos = GetOrigin(myHero)
if XerathMenu.Drawings.DrawR:Value() then DrawCircleMinimap(pos,XerathR.range,0,255,0xff0000ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (40*GetCastLevel(myHero,_Q)+40)+(0.75*GetBonusAP(myHero))
	local WDmg = (45*GetCastLevel(myHero,_W)+45)+(0.9*GetBonusAP(myHero))
	local EDmg = (30*GetCastLevel(myHero,_E)+50)+(0.45*GetBonusAP(myHero))
	local RDmg = ((40*GetCastLevel(myHero,_R)+160)+(0.43*GetBonusAP(myHero)))*(GetCastLevel(myHero,_R)+2)
	local ComboDmg = QDmg + WDmg + EDmg + RDmg
	local WERDmg = WDmg + EDmg + RDmg
	local QERDmg = QDmg + EDmg + RDmg
	local QWRDmg = QDmg + WDmg + RDmg
	local QWEDmg = QDmg + WDmg + EDmg
	local ERDmg = EDmg + RDmg
	local WRDmg = WDmg + RDmg
	local QRDmg = QDmg + RDmg
	local WEDmg = WDmg + EDmg
	local QEDmg = QDmg + EDmg
	local QWDmg = QDmg + WDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if XerathMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_W) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_W) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWEDmg), 0xff008080)
				elseif Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ERDmg), 0xff008080)
				elseif Ready(_W) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WRDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_W) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WEDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QEDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QWDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_W) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, WDmg), 0xff008080)
				elseif Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, EDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		KillSteal()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	if ValidTarget(target, XerathQ.range) then
		if GotBuff(myHero, "XerathArcanopulseChargeUp") > 0 then
			if XerathMenu.Misc.UseQ:Value() then
				if XerathMenu.Prediction.PredictionQ:Value() == 1 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() CastSkillShot2(_Q,GetOrigin(target)) end, XerathMenu.Misc.ED:Value())
					else
						CastSkillShot2(_Q,GetOrigin(target))
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 2 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathQ.speed,XerathQ.delay*1000,XerathQ.range,XerathQ.width,false,true)
							if QPred.HitChance == 1 then
								CastSkillShot2(_Q, QPred.PredPos)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathQ.speed,XerathQ.delay*1000,XerathQ.range,XerathQ.width,false,true)
						if QPred.HitChance == 1 then
							CastSkillShot2(_Q, QPred.PredPos)
						end
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 3 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local qPred = _G.gPred:GetPrediction(target,myHero,XerathQ,true,false)
							if qPred and qPred.HitChance >= 3 then
								CastSkillShot2(_Q, qPred.CastPosition)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local qPred = _G.gPred:GetPrediction(target,myHero,XerathQ,true,false)
						if qPred and qPred.HitChance >= 3 then
							CastSkillShot2(_Q, qPred.CastPosition)
						end
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 4 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local QSpell = IPrediction.Prediction({name="XerathArcanopulse2", range=XerathQ.range, speed=XerathQ.speed, delay=XerathQ.delay, width=XerathQ.width, type="linear", collision=false})
							ts = TargetSelector()
							target = ts:GetTarget(XerathQ.range)
							local x, y = QSpell:Predict(target)
							if x > 2 then
								CastSkillShot2(_Q, y.x, y.y, y.z)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local QSpell = IPrediction.Prediction({name="XerathArcanopulse2", range=XerathQ.range, speed=XerathQ.speed, delay=XerathQ.delay, width=XerathQ.width, type="linear", collision=false})
						ts = TargetSelector()
						target = ts:GetTarget(XerathQ.range)
						local x, y = QSpell:Predict(target)
						if x > 2 then
							CastSkillShot2(_Q, y.x, y.y, y.z)
						end
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 5 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local QPrediction = GetLinearAOEPrediction(target,XerathQ)
							if QPrediction.hitChance > 0.9 then
								CastSkillShot2(_Q, QPrediction.castPos)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local QPrediction = GetLinearAOEPrediction(target,XerathQ)
						if QPrediction.hitChance > 0.9 then
							CastSkillShot2(_Q, QPrediction.castPos)
						end
					end
				end
			end
		else
			CastSkillShot(_Q,GetMousePos())
		end
	end
end
function useW(target)
	if GetDistance(target) < XerathW.range then
		if XerathMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif XerathMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathW.speed,XerathW.delay*1000,XerathW.range,XerathW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif XerathMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,XerathW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif XerathMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="XerathArcaneBarrage2", range=XerathW.range, speed=XerathW.speed, delay=XerathW.delay, width=XerathW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(XerathW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif XerathMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,XerathW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	if GetDistance(target) < XerathE.range then
		if XerathMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif XerathMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathE.speed,XerathE.delay*1000,XerathE.range,XerathE.width,true,false)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif XerathMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,XerathE,false,true)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif XerathMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="XerathMageSpear", range=XerathE.range, speed=XerathE.speed, delay=XerathE.delay, width=XerathE.width, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(XerathE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif XerathMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetLinearAOEPrediction(target,XerathE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end

-- Interrupter

addInterrupterCallback(function(target, spellType, spell)
	if XerathMenu.Interrupter.UseE:Value() then
		if ValidTarget(target, XerathE.range) then
			if CanUseSpell(myHero,_E) == READY then
				if spellType == GAPCLOSER_SPELLS or spellType == CHANELLING_SPELLS then
					useE(target)
				end
			end
		end
	end
end)

-- Auto

OnTick(function(myHero)
	if XerathMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
	end
	if XerathMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				useW(target)
			end
		end
	end
	if XerathMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				useE(target)
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if XerathMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
		if XerathMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				useW(target)
			end
		end
		if XerathMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				useE(target)
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if XerathMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					useQ(target)
				end
			end
		end
		if XerathMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					useW(target)
				end
			end
		end
		if XerathMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					useE(target)
				end
			end
		end
	end
end

-- KillSteal

local info = ""
function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if XerathMenu.KillSteal.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(enemy, XerathR.range) then
					local XerathRDmg = ((40*GetCastLevel(myHero,_R)+160)+(0.43*GetBonusAP(myHero)))*(GetCastLevel(myHero,_R)+2)
					if GetCurrentHP(enemy) < XerathRDmg then
						local EnemyToKS = enemy
						if GotBuff(myHero, "xerathrshots") > 0 then
							if XerathMenu.Prediction.PredictionR:Value() == 1 then
								CastSkillShot(_R,GetOrigin(EnemyToKS))
							elseif XerathMenu.Prediction.PredictionR:Value() == 2 then
								local RPred = GetPredictionForPlayer(GetOrigin(myHero),EnemyToKS,GetMoveSpeed(EnemyToKS),XerathR.speed,XerathR.delay*1000,XerathR.range,XerathR.width,false,true)
								if RPred.HitChance == 1 then
									CastSkillShot(_R, RPred.PredPos)
								end
							elseif XerathMenu.Prediction.PredictionR:Value() == 3 then
								local RPred = _G.gPred:GetPrediction(EnemyToKS,myHero,XerathR,true,false)
								if RPred and RPred.HitChance >= 3 then
									CastSkillShot(_R, RPred.CastPosition)
								end
							elseif XerathMenu.Prediction.PredictionR:Value() == 4 then
								local RSpell = IPrediction.Prediction({name="XerathLocusPulse", range=XerathR.range, speed=XerathR.speed, delay=XerathR.delay, width=XerathR.width, type="circular", collision=false})
								local x, y = RSpell:Predict(EnemyToKS)
								if x > 2 then
									CastSkillShot(_R, y.x, y.y, y.z)
								end
							elseif XerathMenu.Prediction.PredictionR:Value() == 5 then
								local RPrediction = GetCircularAOEPrediction(EnemyToKS,XerathR)
								if RPrediction.hitChance > 0.9 then
									CastSkillShot(_R, RPrediction.castPos)
								end
							end
						else
							info = info.." Killable detected, use R!\n"
						end
					else
						info = ""
					end
				else
					info = ""
				end
			else
				info = ""
			end
		else
			info = ""
		end
	end
end
OnDraw(function()
	DrawText(info,30,450,655,0xff1e90ff)
end)

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, XerathE.range) then
					if XerathMenu.LastHit.UseE:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPE:Value() then
							if CanUseSpell(myHero,_E) == READY then
								local XerathEDmg = (30*GetCastLevel(myHero,_E)+50)+(0.45*GetBonusAP(myHero))
								if GetCurrentHP(minion) < XerathEDmg then
									useE(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if XerathMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if GotBuff(myHero, "XerathArcanopulseChargeUp") > 0 then
						local BestPos, BestHit = GetLineFarmPosition(XerathQ.range, XerathQ.radius)
						if BestPos and BestHit > 2 then
							DelayAction(function() CastSkillShot2(_Q, BestPos) end, 0.5)
						end
					else
						CastSkillShot(_Q,GetMousePos())
					end
				end
			end
		end
		if XerathMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Misc.MPW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetFarmPosition(XerathW.range, XerathW.radius)
					if BestPos and BestHit > 2 then 
						CastSkillShot(_W, BestPos)
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, XerathQ.range) then
						if XerathMenu.JungleClear.UseQ:Value() then
							if GotBuff(myHero, "XerathArcanopulseChargeUp") > 0 then
								DelayAction(function() CastSkillShot2(_Q,GetOrigin(mob)) end, 0.25)
							else
								CastSkillShot(_Q,GetMousePos())
							end
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, XerathW.range) then
						if XerathMenu.JungleClear.UseW:Value() then
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, XerathE.range) then
						if XerathMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if XerathMenu.Misc.AutoLvlUp:Value() then
		if XerathMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

-- Yasuo

elseif "Yasuo" == GetObjectName(myHero) then

require('Interrupter')

WALL_SPELLS = { 
    ["Aatrox"]                      = {_E},
    ["Ahri"]                      = {_Q,_E},
    ["Akali"]                      = {_Q},
    ["Amumu"]                      = {_Q},
    ["Anivia"]                      = {_Q,_E},
    ["Annie"]                      = {_Q},
    ["Ashe"]                      = {_W,_R},
    ["AurelionSol"]                      = {_Q},
    ["Bard"]                      = {_Q},
    ["Blitzcrank"]                      = {_Q},
    ["Brand"]                      = {_Q,_R},
    ["Braum"]                      = {_Q,_R},
    ["Caitlyn"]                      = {_Q,_E,_R},
    ["Cassiopeia"]                      = {_W,_E},
    ["Corki"]                      = {_Q,_R},
    ["Diana"]                      = {_Q},
    ["DrMundo"]                      = {_Q},
    ["Draven"]                      = {_Q,_E,_R},
    ["Ekko"]                      = {_Q},
    ["Elise"]                      = {_Q,_E},
    ["Evelynn"]                      = {_Q},
    ["Ezreal"]                      = {_Q,_W,_R},
    ["FiddleSticks"]                      = {_E},
    ["Fizz"]                      = {_R},
    ["Galio"]                      = {_Q},
    ["Gangplank"]                      = {_Q},
    ["Gnar"]                      = {_Q},
    ["Gragas"]                      = {_Q,_R},
    ["Graves"]                      = {_Q,_R},
    ["Heimerdinger"]                      = {_W},
    ["Illaoi"]                      = {_Q},
    ["Irelia"]                      = {_R},
    ["Ivern"]                      = {_Q},
    ["Janna"]                      = {_Q,_W},
    ["Jayce"]                      = {_Q},
    ["Jhin"]                      = {_Q,_R},
    ["Jinx"]                      = {_W,_R},
    ["Kalista"]                      = {_Q},
    ["Karma"]                      = {_Q},
    ["Kassidan"]                      = {_Q},
    ["Katarina"]                      = {_Q,_R},
    ["Kayle"]                      = {_Q},
    ["Kennen"]                      = {_Q},
    ["KhaZix"]                      = {_W},
    ["Kindred"]                      = {_Q},
    ["Kled"]                      = {_Q},
    ["KogMaw"]                      = {_Q,_E},
    ["Leblanc"]                      = {_Q,_E},
    ["Leesin"]                      = {_Q},
    ["Ivern"]                      = {_Q},
    ["Leona"]                      = {_E},
    ["Lissandra"]                      = {_E},
    ["Lucian"]                      = {_W,_R},
    ["Lulu"]                      = {_Q},
    ["Lux"]                      = {_Q,_E},
    ["Malphite"]                      = {_Q},
    ["Missfortune"]                      = {_R},
    ["Morgana"]                      = {_Q},
    ["Nami"]                      = {_W,_R},
    ["Nautilus"]                      = {_Q},
    ["Nocturne"]                      = {_Q},
    ["Pantheon"]                      = {_Q},
    ["Quinn"]                      = {_Q},
    ["Rakan"]                      = {_Q},
    ["RekSai"]                      = {_Q},
    ["Rengar"]                      = {_E},
    ["Riven"]                      = {_R},
    ["Ryze"]                      = {_Q,_E},
    ["Sejuani"]                      = {_R},
    ["Sivir"]                      = {_Q},
    ["Skarner"]                      = {_E},
    ["Sona"]                      = {_Q,_R},
    ["Shyvana"]                      = {_E},
    ["Swain"]                      = {_Q,_E,_R},
    ["Syndra"]                      = {_E,_R},
    ["Taliyah"]                      = {_Q},
    ["Talon"]                      = {_W,_R},
    ["Teemo"]                      = {_Q},
    ["Thresh"]                      = {_Q},
    ["Tristana"]                      = {_R},
    ["TwistedFate"]                      = {_Q},
    ["Twitch"]                      = {_W,_R},
    ["Urgot"]                      = {_Q,_R},
    ["Varus"]                      = {_Q,_R},
    ["Vayne"]                      = {_E},
    ["Veigar"]                      = {_Q,_R},
    ["Velkoz"]                      = {_Q,_W},
    ["Viktor"]                      = {_E},
    ["Vladimir"]                      = {_E},
    ["Xayah"]                      = {_Q,_W,_R},
    ["Xerath"]                      = {_E},
    ["Yasuo"]                      = {_Q},
    ["Zac"]                      = {_Q},
    ["Zed"]                      = {_Q},
    ["Ziggs"]                      = {_Q,_W,_E},
    ["Zoe"]                      = {_Q,_E},
    ["Zyra"]                      = {_E}
} 

WALL_SPELLS = { 
    ["AatroxE"]                      = {Spellname ="AatroxE",Name= "Aatrox", Spellslot =_E},
    ["AhriOrbofDeception"]                      = {Spellname ="AhriOrbofDeception",Name = "Ahri", Spellslot =_Q},
    ["AhriSeduce"]                      = {Spellname ="AhriSeduce",Name = "Ahri", Spellslot =_E},
    ["AkaliMota"]                      = {Spellname ="AkaliMota",Name = "Akali", Spellslot =_Q},
    ["BandageToss"]                      = {Spellname ="BandageToss",Name ="Amumu",Spellslot =_Q},
    ["FlashFrost"]                      = {Spellname ="FlashFrost",Name = "Anivia", Spellslot =_Q},
    ["Anivia2"]                      = {Spellname ="Frostbite",Name = "Anivia", Spellslot =_E},
    ["Disintegrate"]                      = {Spellname ="Disintegrate",Name = "Annie", Spellslot =_Q},
    ["Volley"]                      = {Spellname ="Volley",Name ="Ashe", Spellslot =_W},
    ["EnchantedCrystalArrow"]                      = {Spellname ="EnchantedCrystalArrow",Name ="Ashe", Spellslot =_R},
    ["AurelionSolQ"]                      = {Spellname ="AurelionSolQ",Name ="AurelionSolQ", Spellslot =_Q},
    ["BardQ"]                      = {Spellname ="BardQ",Name ="BardQ", Spellslot =_Q},
    ["RocketGrabMissile"]                      = {Spellname ="RocketGrabMissile",Name ="Blitzcrank",Spellslot =_Q},
    ["BrandBlaze"]                      = {Spellname ="BrandBlaze",Name ="Brand", Spellslot =_Q},
    ["BrandWildfire"]                      = {Spellname ="BrandWildfire",Name ="Brand", Spellslot =_R},
    ["BraumQ"]                      = {Spellname ="BraumQ",Name ="Braum",Spellslot =_Q},
    ["BraumRWapper"]                      = {Spellname ="BraumRWapper",Name ="Braum",Spellslot =_R},
    ["CaitlynPiltoverPeacemaker"]                      = {Spellname ="CaitlynPiltoverPeacemaker",Name ="Caitlyn",Spellslot =_Q},
    ["CaitlynEntrapment"]                      = {Spellname ="CaitlynEntrapment",Name ="Caitlyn",Spellslot =_E},
    ["CaitlynAceintheHole"]                      = {Spellname ="CaitlynAceintheHole",Name ="Caitlyn",Spellslot =_R},
    ["CassiopeiaMiasma"]                      = {Spellname ="CassiopeiaMiasma",Name ="Cassiopeia",Spellslot =_W},
    ["CassiopeiaTwinFang"]                      = {Spellname ="CassiopeiaTwinFang",Name ="Cassiopeia",Spellslot =_E},
    ["PhosphorusBomb"]                      = {Spellname ="PhosphorusBomb",Name ="Corki",Spellslot =_Q},
    ["MissileBarrage"]                      = {Spellname ="MissileBarrage",Name ="Corki",Spellslot =_R},
    ["DianaArc"]                      = {Spellname ="DianaArc",Name ="Diana",Spellslot =_Q},
    ["InfectedCleaverMissileCast"]                      = {Spellname ="InfectedCleaverMissileCast",Name ="DrMundo",Spellslot =_Q},
    ["dravenspinning"]                      = {Spellname ="dravenspinning",Name ="Draven",Spellslot =_Q},
    ["DravenDoubleShot"]                      = {Spellname ="DravenDoubleShot",Name ="Draven",Spellslot =_E},
    ["DravenRCast"]                      = {Spellname ="DravenRCast",Name ="Draven",Spellslot =_R},
    ["EkkoQ"]                      = {Spellname ="EkkoQ",Name ="Ekko",Spellslot =_Q},
    ["EliseHumanQ"]                      = {Spellname ="EliseHumanQ",Name ="Elise",Spellslot =_Q},
    ["EliseHumanE"]                      = {Spellname ="EliseHumanE",Name ="Elise",Spellslot =_E},
    ["EvelynnQ"]                      = {Spellname ="EvelynnQ",Name ="Evelynn",Spellslot =_Q},
    ["EzrealMysticShot"]                      = {Spellname ="EzrealMysticShot",Name ="Ezreal",Spellslot =_Q,},
    ["EzrealEssenceFlux"]                      = {Spellname ="EzrealEssenceFlux",Name ="Ezreal",Spellslot =_W},
    ["EzrealArcaneShift"]                      = {Spellname ="EzrealArcaneShift",Name ="Ezreal",Spellslot =_R},
    ["FiddlesticksDarkWind"]                      = {Spellname ="FiddlesticksDarkWind",Name ="FiddleSticks",Spellslot =_E},
    ["FizzMarinerDoom"]                      = {Spellname ="FizzMarinerDoom",Name = "Fizz", Spellslot =_R},
    ["GalioResoluteSmite"]                      = {Spellname ="GalioResoluteSmite",Name ="Galio",Spellslot =_Q},
    ["Parley"]                      = {Spellname ="Parley",Name ="Gangplank",Spellslot =_Q},
    ["GnarQ"]                      = {Spellname ="GnarQ",Name ="Gnar",Spellslot =_Q},
    ["GragasQ"]                      = {Spellname ="GragasQ",Name ="Gragas",Spellslot =_Q},
    ["GragasR"]                      = {Spellname ="GragasR",Name ="Gragas",Spellslot =_R},
    ["GravesClusterShot"]                      = {Spellname ="GravesClusterShot",Name ="Graves",Spellslot =_Q},
    ["GravesChargeShot"]                      = {Spellname ="GravesChargeShot",Name ="Graves",Spellslot =_R},
    ["HeimerdingerW"]                      = {Spellname ="HeimerdingerW",Name ="Heimerdinger",Spellslot =_W},
    ["IllaoiQ"]                      = {Spellname ="IllaoiQ",Name ="Illaoi",Spellslot =_Q},
    ["IreliaTranscendentBlades"]                      = {Spellname ="IreliaTranscendentBlades",Name ="Irelia",Spellslot =_R},
    ["IvernQ"]                      = {Spellname ="IvernQ",Name ="Ivern",Spellslot =_Q},
    ["HowlingGale"]                      = {Spellname ="HowlingGale",Name ="Janna",Spellslot =_Q},
    ["Zephyr"]                      = {Spellname ="Zephyr",Name ="Janna",Spellslot =_W},
    ["JayceToTheSkies"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["jayceshockblast"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["JhinQ"]                      = {Spellname ="JhinQ",Name ="Jhin",Spellslot =_Q},
    ["JhinRShot"]                      = {Spellname ="JhinRShot",Name ="Jhin",Spellslot =_R},
    ["JinxW"]                      = {Spellname ="JinxW",Name ="Jinx",Spellslot =_W},
    ["JinxR"]                      = {Spellname ="JinxR",Name ="Jinx",Spellslot =_R},
    ["KalistaMysticShot"]                      = {Spellname ="KalistaMysticShot",Name ="Kalista",Spellslot =_Q},
    ["KarmaQ"]                      = {Spellname ="KarmaQ",Name ="Karma",Spellslot =_Q},
    ["NullLance"]                      = {Spellname ="NullLance",Name ="Kassidan",Spellslot =_Q},
    ["KatarinaQ"]                      = {Spellname ="KatarinaQ",Name ="Katarina",Spellslot =_Q},
    ["KatarinaR"]                      = {Spellname ="KatarinaR",Name ="Katarina",Spellslot =_R},
    ["KayleQ"]                      = {Spellname ="KayleQ",Name ="Kayle",Spellslot =_Q},
    ["KennenShurikenHurlMissile1"]                      = {Spellname ="KennenShurikenHurlMissile1",Name ="Kennen",Spellslot =_Q},
    ["KhazixW"]                      = {Spellname ="KhazixW",Name ="Khazix",Spellslot =_W},
    ["KhazixWLong"]                      = {Spellname ="KhazixWLong",Name ="Khazix",Spellslot =_W},
    ["KindredQ"]                      = {Spellname ="KindredQ",Name ="Kindred",Spellslot =_Q},
    ["KledQ"]                      = {Spellname ="KledQ",Name ="Kled",Spellslot =_Q},
    ["KledRiderQ"]                      = {Spellname ="KledRiderQ",Name ="Kled",Spellslot =_Q},
    ["KogMawQ"]                      = {Spellname ="KogMawQ",Name ="KogMaw",Spellslot =_Q},
    ["KogMawVoidOoze"]                      = {Spellname ="KogMawE",Name ="KogMaw",Spellslot =_E},
    ["LeblancChaosOrb"]                      = {Spellname ="LeblancChaosOrb",Name ="Leblanc",Spellslot =_Q},
    ["LeblancSoulShackle"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["LeblancSoulShackleM"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["BlindMonkQOne"]                      = {Spellname ="BlindMonkQOne",Name ="Leesin",Spellslot =_Q},
    ["LeonaZenithBladeMissle"]                      = {Spellname ="LeonaZenithBladeMissle",Name ="Leona",Spellslot =_E},
    ["LissandraE"]                      = {Spellname ="LissandraE",Name ="Lissandra",Spellslot =_E},
    ["LucianW"]                      = {Spellname ="LucianW",Name ="Lucian",Spellslot =_W},
    ["LucianRMis"]                      = {Spellname ="LucianR",Name ="Lucian",Spellslot =_R},
    ["LuluQ"]                      = {Spellname ="LuluQ",Name ="Lulu",Spellslot =_Q},
    ["LuxLightBinding"]                      = {Spellname ="LuxLightBinding",Name ="Lux",Spellslot =_Q},
    ["LuxLightStrikeKugel"]                      = {Spellname ="LuxLightStrikeKugel",Name ="Lux",Spellslot =_E},
    ["MalphiteQ"]                      = {Spellname ="MalphiteQ",Name ="Malphite",Spellslot =_Q},
    ["MissFortuneBulletTime"]                      = {Spellname ="MissFortuneBulletTime",Name ="Missfortune",Spellslot =_R},
    ["DarkBindingMissile"]                      = {Spellname ="DarkBindingMissile",Name ="Morgana",Spellslot =_Q},
    ["NamiW"]                      = {Spellname ="NamiW",Name ="Nami",Spellslot =_W},
    ["NamiR"]                      = {Spellname ="NamiR",Name ="Nami",Spellslot =_R},
    ["NautilusAnchorDrag"]                      = {Spellname ="NautilusAnchorDrag",Name ="Nautilus",Spellslot =_Q},
    ["JavelinToss"]                      = {Spellname ="JavelinToss",Name ="Nidalee",Spellslot =_Q},
    ["NocturneDuskbringer"]                      = {Spellname ="NocturneDuskbringer",Name ="Nocturne",Spellslot =_Q},
    ["Pantheon_Throw"]                      = {Spellname ="Pantheon_Throw",Name ="Pantheon",Spellslot =_Q},
    ["QuinnQ"]                      = {Spellname ="QuinnQ",Name ="Quinn",Spellslot =_Q},
    ["RakanQ"]                      = {Spellname ="RakanQ",Name ="Rakan",Spellslot =_Q},
    ["reksaiqburrowed"]                      = {Spellname ="reksaiqburrowed",Name ="RekSai",Spellslot =_Q},
    ["RengarE"]                      = {Spellname ="RengarE",Name ="Rengar",Spellslot =_E},
    ["rivenizunablade"]                      = {Spellname ="rivenizunablade",Name ="Riven",Spellslot =_R},
    ["Overload"]                      = {Spellname ="Overload",Name ="Ryze",Spellslot =_Q},
    ["SpellFlux"]                      = {Spellname ="SpellFlux",Name ="Ryze",Spellslot =_E},
    ["SejuaniGlacialPrisonStart"]                      = {Spellname ="SejuaniGlacialPrisonStart",Name ="Sejuani",Spellslot =_R},
    ["SivirQ"]                      = {Spellname ="SivirQ",Name ="Sivir",Spellslot =_Q},
    ["SkarnerFractureMissileSpell"]                      = {Spellname ="SkarnerFractureMissileSpell",Name ="Skarner",Spellslot =_E},
    ["SonaQ"]                      = {Spellname ="SonaQ",Name ="Sona",Spellslot =_Q},
    ["SonaCrescendo"]                      = {Spellname ="SonaCrescendo",Name ="Sona",Spellslot =_R},
    ["ShyvanaFireball"]                      = {Spellname ="ShyvanaFireball",Name ="Shyvana",Spellslot =_E},
    ["SwainDecrepify"]                      = {Spellname ="SwainDecrepify",Name ="Swain",Spellslot =_Q},
    ["SwainTorment"]                      = {Spellname ="SwainTorment",Name ="Swain",Spellslot =_E},
    ["SwainMetamorphism"]                      = {Spellname ="SwainMetamorphism",Name ="Swain",Spellslot =_R},
    ["SyndraE"]                      = {Spellname ="SyndraE",Name ="Syndra",Spellslot =_E},
    ["SyndraR"]                      = {Spellname ="SyndraR",Name ="Syndra",Spellslot =_R},
    ["TaliyahQMis"]                      = {Spellname ="TaliyahQMis",Name ="Taliyah",Spellslot =_Q},
    ["TalonRake"]                      = {Spellname ="TalonRake",Name ="Talon",Spellslot =_W},
    ["TalonShadowAssault"]                      = {Spellname ="TalonShadowAssault",Name ="Talon",Spellslot =_R},
    ["BlindingDart"]                      = {Spellname ="BlindingDart",Name ="Teemo",Spellslot =_Q},
    ["Thresh"]                      = {Spellname ="ThreshQ",Name ="Thresh",Spellslot =_Q},
    ["BusterShot"]                      = {Spellname ="BusterShot",Name ="Tristana",Spellslot =_R},
    ["WildCards"]                      = {Spellname ="WildCards",Name ="TwistedFate",Spellslot =_Q},
    ["TwitchVenomCask"]                      = {Spellname ="TwitchVenomCask",Name ="Twitch",Spellslot =_W},
    ["TwitchSprayAndPrayAttack"]                      = {Spellname ="TwitchSprayAndPrayAttack",Name ="Twitch",Spellslot =_R},
    ["UrgotHeatseekingLineMissile"]                      = {Spellname ="UrgotHeatseekingLineMissile",Name ="Urgot",Spellslot =_Q},
    ["UrgotR"]                      = {Spellname ="UrgotR",Name ="Urgot",Spellslot =_R},
    ["VarusQ"]                      = {Spellname ="VarusQ",Name ="Varus",Spellslot =_Q},
    ["VarusR"]                      = {Spellname ="VarusR",Name ="Varus",Spellslot =_R},
    ["VayneCondemm"]                      = {Spellname ="VayneCondemm",Name ="Vayne",Spellslot =_E},
    ["VeigarBalefulStrike"]                      = {Spellname ="VeigarBalefulStrike",Name ="Veigar",Spellslot =_Q},
    ["VeigarPrimordialBurst"]                      = {Spellname ="VeigarPrimordialBurst",Name ="Veigar",Spellslot =_R},
    ["VelkozQ"]                      = {Spellname ="VelkozQ",Name ="Velkoz",Spellslot =_Q},
    ["VelkozW"]                      = {Spellname ="VelkozW",Name ="Velkoz",Spellslot =_W},
    ["ViktorDeathRay"]                      = {Spellname ="ViktorDeathRay",Name ="Viktor",Spellslot =_E},
    ["VladimirE"]                      = {Spellname ="VladimirE",Name ="Vladimir",Spellslot =_E},
    ["XayahQ"]                      = {Spellname ="XayahQ",Name ="Xayah",Spellslot =_Q},
    ["XayahW"]                      = {Spellname ="XayahW",Name ="Xayah",Spellslot =_W},
    ["XayahR"]                      = {Spellname ="XayahR",Name ="Xayah",Spellslot =_R},
    ["XerathMageSpear"]                      = {Spellname ="XerathMageSpear",Name ="Xerath",Spellslot =_E},
    ["YasuoQ3W"]                      = {Spellname ="YasuoQ3W",Name ="Yasuo",Spellslot =_Q},
    ["ZacQ"]                      = {Spellname ="ZacQ",Name ="Zac",Spellslot =_Q},
    ["ZedShuriken"]                      = {Spellname ="ZedShuriken",Name ="Zed",Spellslot =_Q},
    ["ZiggsQ"]                      = {Spellname ="ZiggsQ",Name ="Ziggs",Spellslot =_Q},
    ["ZiggsW"]                      = {Spellname ="ZiggsW",Name ="Ziggs",Spellslot =_W},
    ["ZiggsE"]                      = {Spellname ="ZiggsE",Name ="Ziggs",Spellslot =_E},
    ["ZoeQ"]                      = {Spellname ="ZoeQ",Name ="Zoe",Spellslot =_Q},
    ["ZoeE"]                      = {Spellname ="ZoeE",Name ="Zoe",Spellslot =_E},
    ["ZyraGraspingRoots"]                      = {Spellname ="ZyraGraspingRoots",Name ="Zyra",Spellslot =_E}
} 

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Yasuo loaded successfully!")
local YasuoMenu = Menu("[T01] Yasuo", "[T01] Yasuo")
YasuoMenu:Menu("Auto", "Auto")
YasuoMenu.Auto:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.Auto:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.Auto:Boolean('UseW', 'Use W [Wind Wall]', true)
YasuoMenu:Menu("Combo", "Combo")
YasuoMenu.Combo:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.Combo:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.Combo:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu.Combo:Boolean('UseR', 'Use R [Last Breath]', true)
YasuoMenu:Menu("Harass", "Harass")
YasuoMenu.Harass:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.Harass:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.Harass:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu:Menu("KillSteal", "KillSteal")
YasuoMenu.KillSteal:Boolean('UseR', 'Use R [Last Breath]', true)
YasuoMenu:Menu("LastHit", "LastHit")
YasuoMenu.LastHit:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu:Menu("LaneClear", "LaneClear")
YasuoMenu.LaneClear:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.LaneClear:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.LaneClear:Boolean('UseE', 'Use E [Sweeping Blade]', false)
YasuoMenu:Menu("JungleClear", "JungleClear")
YasuoMenu.JungleClear:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.JungleClear:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.JungleClear:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu:Menu("Interrupter", "Interrupter")
YasuoMenu.Interrupter:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu:Menu("Prediction", "Prediction")
YasuoMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 3, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
YasuoMenu.Prediction:DropDown("PredictionQ3", "Prediction: Q3", 3, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
YasuoMenu:Menu("Drawings", "Drawings")
YasuoMenu.Drawings:Boolean('DrawQE', 'Draw QE Range', true)
YasuoMenu.Drawings:Boolean('DrawQ3', 'Draw Q3 Range', true)
YasuoMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
YasuoMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
YasuoMenu.Drawings:Boolean('DrawDMG', 'Draw Max QWER Damage', true)
YasuoMenu:Menu("Misc", "Misc")
YasuoMenu.Misc:Boolean('UI', 'Use Items', true)
YasuoMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
YasuoMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
YasuoMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
YasuoMenu.Misc:Slider('HP','HP-Manager: R', 25, 0, 100, 5)

-- > #Deftsu
function GenerateWallPos(unitPos)
	local mydpos = GetOrigin(myHero)
	local tV = {x = (unitPos.x-mydpos.x), z = (unitPos.z-mydpos.z)}
	local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
	return {x = mydpos.x + 400 * tV.x / len, y = 0, z = mydpos.z + 400 * tV.z / len}
end
function GenerateSpellPos(unitPos, spellPos, range)
	local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
	local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
	return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end
OnProcessSpell(function(unit, spell)
	if YasuoMenu.Auto.UseW:Value() and WALL_SPELLS[spell.name] then
		myHero = GetMyHero()
		if unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GetDistance(unit) < 1500 then
			unispells = WALL_SPELLS[GetObjectName(unit)]
			if myHero == spell.target and GetRange(unit) >= 450 and CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 and not spell.name:lower():find("attack") then
				local wPos = GetOrigin(unit)
				CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
			elseif spell.endPos and not spell.name:lower():find("attack") then
				local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GetDistance(unit, myHero))
				if GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
					local wPos = GetOrigin(unit)
					CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
				end
			end
		end
	end
end)
-- < #Deftsu

local YasuoQ = { range = 475, radius = 40, speed = math.huge, delay = 0.25, type = "line", collision = false, source = myHero }
local YasuoQ3 = { range = 1000, radius = 90, speed = math.huge, delay = 0.25, type = "line", col = {"yasuowall"}, collision = false, source = myHero }
local YasuoW = { range = 400 }
local YasuoE = { range = 475 }
local YasuoR = { range = 1400 }

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if YasuoMenu.Drawings.DrawQE:Value() then DrawCircle(pos,YasuoQ.range,1,25,0xff00bfff) end
if YasuoMenu.Drawings.DrawQ3:Value() then DrawCircle(pos,YasuoQ3.range,1,25,0xff4169e1) end
if YasuoMenu.Drawings.DrawW:Value() then DrawCircle(pos,YasuoW.range,1,25,0xff1e90ff) end
if YasuoMenu.Drawings.DrawR:Value() then DrawCircle(pos,YasuoR.range,1,25,0xff0000ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (25*GetCastLevel(myHero,_Q)-5)+(GetBonusDmg(myHero)+GetBaseDamage(myHero))
	local EDmg = (10*GetCastLevel(myHero,_E)+50)+(0.2*GetBonusDmg(myHero))+(0.6*GetBonusAP(myHero))
	local RDmg = (100*GetCastLevel(myHero,_R)+100)+(1.5*GetBonusDmg(myHero))
	local ComboDmg = QDmg + EDmg + RDmg
	local QRDmg = QDmg + RDmg
	local ERDmg = EDmg + RDmg
	local QEDmg = QDmg + EDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if YasuoMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QEDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, EDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		KillSteal()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	if GetCastRange(myHero,_Q) < 500 then
		if YasuoMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),YasuoQ.speed,YasuoQ.delay*1000,YasuoQ.range,YasuoQ.radius,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,YasuoQ,true,false)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="YasuoQ", range=YasuoQ.range, speed=YasuoQ.speed, delay=YasuoQ.delay, width=YasuoQ.radius, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(YasuoQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetPrediction(target,YasuoQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useQ3(target)
	if GetCastRange(myHero,_Q) > 600 then
		if GetDistance(target) < YasuoQ3.range then
			if YasuoMenu.Prediction.PredictionQ3:Value() == 1 then
				DelayAction(function() CastSkillShot(_Q,GetOrigin(target)) end, 0.25)
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 2 then
				local Q3Pred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),YasuoQ3.speed,YasuoQ3.delay*1000,YasuoQ3.range,YasuoQ3.radius,false,true)
				if Q3Pred.HitChance == 1 then
					DelayAction(function() CastSkillShot(_Q, Q3Pred.PredPos) end, 0.25)
				end
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 3 then
				local q3Pred = _G.gPred:GetPrediction(target,myHero,YasuoQ3,true,false)
				if q3Pred and q3Pred.HitChance >= 3 then
					DelayAction(function() CastSkillShot(_Q, q3Pred.CastPosition) end, 0.25)
				end
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 4 then
				local Q3Spell = IPrediction.Prediction({name="YasuoQ3W", range=YasuoQ3.range, speed=YasuoQ3.speed, delay=YasuoQ3.delay, width=YasuoQ3.radius, type="linear", collision=false})
				ts = TargetSelector()
				target = ts:GetTarget(YasuoQ3.range)
				local x, y = Q3Spell:Predict(target)
				if x > 2 then
					DelayAction(function() CastSkillShot(_Q, y.x, y.y, y.z) end, 0.25)
				end
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 5 then
				local Q3Prediction = GetPrediction(target,YasuoQ3)
				if Q3Prediction.hitChance > 0.9 then
					DelayAction(function() CastSkillShot(_Q, Q3Prediction.castPos) end, 0.25)
				end
			end
		end
	end
end
function useW(target)
	CastSkillShot(_W,GetOrigin(target))
end
function useE(target)
	CastTargetSpell(target, _E)
end
function useR(target)
	if 100*GetCurrentHP(target)/GetMaxHP(target) < YasuoMenu.Misc.HP:Value() then
		if EnemiesAround(myHero, YasuoR.range) >= YasuoMenu.Misc.X:Value() then
			CastTargetSpell(target, _R)
		end
	end
end

-- Interrupter

addInterrupterCallback(function(target, spellType, spell)
	if YasuoMenu.Interrupter.UseQ3:Value() then
		if ValidTarget(target, YasuoQ3.range) then
			if GetCastRange(myHero,_Q) > 500 then
				if CanUseSpell(myHero,_Q) == READY then
					if spellType == GAPCLOSER_SPELLS or spellType == CHANELLING_SPELLS then
						CastSkillShot(_Q,GetOrigin(target))
					end
				end
			end
		end
	end
end)

-- Auto

OnTick(function(myHero)
	if YasuoMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY then
			DelayAction(function() useQ(target) end, 0.25)
		end
	end
	if YasuoMenu.Auto.UseQ3:Value() then
		if CanUseSpell(myHero,_Q) == READY then
			useQ3(target)
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if YasuoMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
		if YasuoMenu.Combo.UseQ3:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ3(target)
			end
		end
		if YasuoMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if GotBuff(target, "YasuoDashWrapper") == 0 then
					if GetDistance(target) < YasuoE.range and GetDistance(target) > GetRange(myHero) then
						useE(target)
					elseif GetDistance(target) < YasuoE.range+1300 and GetDistance(target) > YasuoE.range then
						for _, minion in pairs(minionManager.objects) do
							if GetTeam(minion) == MINION_ENEMY and GetDistance(minion) <= YasuoE.range then
								EPos = Vector(myHero)+(Vector(target)-Vector(myHero)):normalized()*YasuoE.range
								if GetDistance(EPos,target) < GetDistance(minion,target) then
									useE(minion)
								end
							end
						end
					end
				end
			end
		end
		if YasuoMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, YasuoR.range) then
					useR(target)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if YasuoMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
		if YasuoMenu.Harass.UseQ3:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ3(target)
			end
		end
		if YasuoMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if GotBuff(target, "YasuoDashWrapper") == 0 then
					if GetDistance(target) < YasuoE.range and GetDistance(target) > GetRange(myHero) then
						useE(target)
					elseif GetDistance(target) < YasuoE.range+1300 and GetDistance(target) > YasuoE.range then
						for _, minion in pairs(minionManager.objects) do
							if GetTeam(minion) == MINION_ENEMY and GetDistance(minion) <= YasuoE.range then
								EPos = Vector(myHero)+(Vector(target)-Vector(myHero)):normalized()*YasuoE.range
								if GetDistance(EPos,target) < GetDistance(minion,target) then
									useE(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if YasuoMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, YasuoR.range) then
				if CanUseSpell(myHero,_R) == READY then
					local YasuoRDmg = (100*GetCastLevel(myHero,_R)+100)+(1.5*GetBonusDmg(myHero))
					if GetCurrentHP(enemy) < YasuoRDmg then
						CastTargetSpell(enemy, _R)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if GotBuff(minion, "YasuoDashWrapper") == 0 then
					if ValidTarget(minion, YasuoE.range) then
						if YasuoMenu.LastHit.UseE:Value() then
							if CanUseSpell(myHero,_E) == READY then
								local YasuoEDmg = (10*GetCastLevel(myHero,_E)+50)+(0.2*GetBonusDmg(myHero))+(0.6*GetBonusAP(myHero))
								if GetCurrentHP(minion) < YasuoEDmg then
									CastTargetSpell(minion, _E)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if CanUseSpell(myHero,_Q) == READY then
					if GetCastRange(myHero,_Q) > 600 then
						if ValidTarget(minion, YasuoQ3.range) then
							if YasuoMenu.LaneClear.UseQ3:Value() then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					else
						if ValidTarget(minion, YasuoQ.range) then
							if YasuoMenu.LaneClear.UseQ:Value() then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if GotBuff(minion, "YasuoDashWrapper") == 0 then
						if ValidTarget(minion, YasuoE.range) then
							if YasuoMenu.LaneClear.UseE:Value() then
								CastTargetSpell(minion, _E)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if GetCastRange(myHero,_Q) > 600 then
						if ValidTarget(mob, YasuoQ3.range) then
							if YasuoMenu.JungleClear.UseQ3:Value() then
								CastSkillShot(_Q,GetOrigin(mob))
							end
						end
					else
						if ValidTarget(mob, YasuoQ.range) then
							if YasuoMenu.JungleClear.UseQ:Value() then
								CastSkillShot(_Q,GetOrigin(mob))
							end
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if GotBuff(mob, "YasuoDashWrapper") == 0 then
						if ValidTarget(mob, YasuoE.range) then
							if YasuoMenu.JungleClear.UseE:Value() then
								CastTargetSpell(mob,_E)
							end
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if YasuoMenu.Misc.UI:Value() then
			local target = GetCurrentTarget()
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

OnTick(function(myHero)
	if YasuoMenu.Misc.AutoLvlUp:Value() then
		if YasuoMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)

-- Zed

elseif "Zed" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Zed loaded successfully!")
local ZedMenu = Menu("[T01] Zed", "[T01] Zed")
ZedMenu:Menu("Auto", "Auto")
ZedMenu.Auto:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.Auto:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu:Menu("Combo", "Combo")
ZedMenu.Combo:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.Combo:Boolean('UseW', 'Use W [Living Shadow]', true)
ZedMenu.Combo:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu.Combo:Boolean('UseR', 'Use R [Death Mark]', true)
ZedMenu.Combo:Boolean('GapW', 'Gapclose Using W', true)
ZedMenu:Menu("Harass", "Harass")
ZedMenu.Harass:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.Harass:Boolean('UseW', 'Use W [Living Shadow]', true)
ZedMenu.Harass:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu.Harass:Boolean('GapW', 'Gapclose Using W', false)
ZedMenu:Menu("LastHit", "LastHit")
ZedMenu.LastHit:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.LastHit:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu:Menu("LaneClear", "LaneClear")
ZedMenu.LaneClear:Boolean('UseQ', 'Use Q [Razor Shuriken]', false)
ZedMenu.LaneClear:Boolean('UseE', 'Use E [Shadow Slash]', false)
ZedMenu:Menu("JungleClear", "JungleClear")
ZedMenu.JungleClear:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.JungleClear:Boolean('UseW', 'Use W [Living Shadow]', true)
ZedMenu.JungleClear:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu:Menu("Prediction", "Prediction")
ZedMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 3, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
ZedMenu:Menu("Drawings", "Drawings")
ZedMenu.Drawings:Boolean('DrawQ', 'Draw Q Range', true)
ZedMenu.Drawings:Boolean('DrawW', 'Draw W Range', true)
ZedMenu.Drawings:Boolean('DrawE', 'Draw E Range', true)
ZedMenu.Drawings:Boolean('DrawR', 'Draw R Range', true)
ZedMenu.Drawings:Boolean('DrawDMG', 'Draw Max QER Damage', true)
ZedMenu:Menu("Misc", "Misc")
ZedMenu.Misc:Boolean('UI', 'Use Items', true)
ZedMenu.Misc:Boolean('AutoLvlUp', 'Level-Up', true)
ZedMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
ZedMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
ZedMenu.Misc:Slider('HP','HP-Manager: R', 25, 0, 100, 5)

local ZedQ = { range = 900, radius = 50, width = 100, speed = 1600, delay = 0.25, type = "line", collision = false, source = myHero, col = {"Zedwall"}}
local ZedW = { range = 650, radius = 80, width = 500, speed = 1750, delay = 0.25, type = "line", collision = false, source = myHero, col = {"Zedwall"}}
local ZedE = { range = 290 }
local ZedR = { range = 625 }
local GlobalTimer = 0

OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if ZedMenu.Drawings.DrawQ:Value() then DrawCircle(pos,ZedQ.range,1,25,0xff00bfff) end
if ZedMenu.Drawings.DrawW:Value() then DrawCircle(pos,ZedW.range,1,25,0xff4169e1) end
if ZedMenu.Drawings.DrawE:Value() then DrawCircle(pos,ZedE.range,1,25,0xff1e90ff) end
if ZedMenu.Drawings.DrawR:Value() then DrawCircle(pos,ZedR.range,1,25,0xff0000ff) end
end)

OnDraw(function(myHero)
	local target = GetCurrentTarget()
	local QDmg = (35*GetCastLevel(myHero,_Q)+45)+(0.9*GetBonusDmg(myHero))+(26.25*GetCastLevel(myHero,_Q)+33.75)+(0.675*GetBonusDmg(myHero))
	local EDmg = (25*GetCastLevel(myHero,_E)+45)+(0.8*GetBonusDmg(myHero))
	local RDmg = (GetBonusDmg(myHero)+GetBaseDamage(myHero))+((0.1*GetCastLevel(myHero,_R)+0.15)*(QDmg+EDmg))
	local ComboDmg = QDmg + EDmg + RDmg
	local QRDmg = QDmg + RDmg
	local ERDmg = EDmg + RDmg
	local QEDmg = QDmg + EDmg
	for _, enemy in pairs(GetEnemyHeroes()) do
		if ValidTarget(enemy) then
			if ZedMenu.Drawings.DrawDMG:Value() then
				if Ready(_Q) and Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ComboDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QRDmg), 0xff008080)
				elseif Ready(_E) and Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, ERDmg), 0xff008080)
				elseif Ready(_Q) and Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QEDmg), 0xff008080)
				elseif Ready(_Q) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, QDmg), 0xff008080)
				elseif Ready(_E) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, EDmg), 0xff008080)
				elseif Ready(_R) then
					DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, CalcDamage(myHero, enemy, 0, RDmg), 0xff008080)
				end
			end
		end
	end
end)

OnTick(function(myHero)
	target = GetCurrentTarget()
		Combo()
		Harass()
		LastHit()
		LaneClear()
		JungleClear()
end)

function useQ(target)
	if GetDistance(target) < ZedQ.range then
		if ZedMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif ZedMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedQ.speed,ZedQ.delay*1000,ZedQ.range,ZedQ.radius,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif ZedMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,ZedQ,true,false)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif ZedMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="ZedQMissile", range=ZedQ.range, speed=ZedQ.speed, delay=ZedQ.delay, width=ZedQ.radius, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(ZedQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif ZedMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,ZedQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useE(target)
	CastSpell(_E)
end
function useR(target)
	if 100*GetCurrentHP(target)/GetMaxHP(target) < ZedMenu.Misc.HP:Value() then
		if EnemiesAround(myHero, ZedR.range) >= ZedMenu.Misc.X:Value() then
			CastTargetSpell(target, _R)
		end
	end
end

-- Auto

OnTick(function(myHero)
	if ZedMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == ONCOOLDOWN then
			if ValidTarget(target, ZedQ.range) then
				useQ(target)
			end
		end
	end
	if ZedMenu.Auto.UseE:Value() then
		if CanUseSpell(myHero,_E) == READY then
			if ValidTarget(target, ZedE.range) then
				useE(target)
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if ZedMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) and CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ZedW.range) then
					if ZedMenu.Combo.GapW:Value() then
						local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
						if WPred.HitChance == 1 then
							CastSkillShot(_W, WPred.PredPos)
							useE(target)
						end
					else
						local TimerW = GetTickCount()
						if (GlobalTimer + 5500) < TimerW then
							local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
							if WPred.HitChance == 1 then
								CastSkillShot(_W, WPred.PredPos)
								useE(target)
								GlobalTimer = TimerW
							end
						end
					end
				end
			end
		end
		if ZedMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ZedQ.range) then
					useQ(target)
				end
			end
		end
		if ZedMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ZedE.range) then
					useE(target)
				end
			end
		end
		if ZedMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, ZedR.range) then
					if GotBuff(target,"zedrtargetmark") == 0 then
						useR(target)
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if ZedMenu.Harass.UseW:Value() then
			if CanUseSpell(myHero,_W) and CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ZedW.range) then
					if ZedMenu.Harass.GapW:Value() then
						local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
						if WPred.HitChance == 1 then
							CastSkillShot(_W, WPred.PredPos)
							useE(target)
						end
					else
						local TimerW = GetTickCount()
						if (GlobalTimer + 5500) < TimerW then
							local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
							if WPred.HitChance == 1 then
								CastSkillShot(_W, WPred.PredPos)
								useE(target)
								GlobalTimer = TimerW
							end
						end
					end
				end
			end
		end
		if ZedMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ZedQ.range) then
					useQ(target)
				end
			end
		end
		if ZedMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ZedE.range) then
					useE(target)
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, ZedQ.range) then
					if ZedMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local ZedQDmg = (21*GetCastLevel(myHero,_Q)+27)+(0.54*GetBonusDmg(myHero))
							if GetCurrentHP(minion) < ZedQDmg then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					end
				end
				if ValidTarget(minion, ZedE.range) then
					if ZedMenu.LastHit.UseE:Value() then
						if CanUseSpell(myHero,_E) == READY then
							local ZedEDmg = (25*GetCastLevel(myHero,_E)+45)+(0.8*GetBonusDmg(myHero))
							if GetCurrentHP(minion) < ZedEDmg then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if ZedMenu.LaneClear.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				local BestPos, BestHit = GetLineFarmPosition(ZedQ.range, ZedQ.radius)
				if BestPos and BestHit > 2 then  
					CastSkillShot(_Q, BestPos)
				end
			end
		end
		if ZedMenu.LaneClear.UseE:Value() then
			for _, minion in pairs(minionManager.objects) do
				if GetTeam(minion) == MINION_ENEMY then
					if ValidTarget(minion, ZedE.range) then
						if ZedMenu.LaneClear.UseE:Value() then
							if CanUseSpell(myHero,_E) == READY then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, ZedW.range) then
						if ZedMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, ZedQ.range) then
						if ZedMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, ZedE.range) then
						if ZedMenu.JungleClear.UseE:Value() then
							useE(mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if ZedMenu.Misc.UI:Value() then
			local target = GetCurrentTarget()
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

OnTick(function(myHero)
	if ZedMenu.Misc.AutoLvlUp:Value() then
		if ZedMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end)
end
