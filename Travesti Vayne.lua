--        __      ___ _    _             
--        \ \    / (_) |  | |            
--  ___ ___\ \  / / _| | _| |_ ___  _ __ 
-- / _ \_  /\ \/ / | | |/ / __/ _ \| '__|
--|  __// /  \  /  | |   <| || (_) | |   
-- \___/___|  \/   |_|_|\_\\__\___/|_|   

-- MENU PART START
Config = scriptConfig(1, "ezViktor", "Viktor.lua") -- Add Menu Main Item -> ezViktor
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true) -- Add Menu Sub Item -> Use Q
Config.addParam("W", "Use W (defensive)", SCRIPT_PARAM_ONOFF, true) -- Add Menu Sub Item -> Use W (defensive)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true) -- Add Menu Sub Item -> Use E
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true) -- Add Menu Sub Item -> Use R
-- MENU PART END

-- CHAT PART START
PrintChat("<font color='#00aaff'>Welcome to ezViktor Version 1.0</font>")
PrintChat("<font color='#00aaff'>This Script is optimized for Inspired.lua v13 and GoS LUA API v0.0.5</font>")
-- CHAT PART END

-- SCRIPT PART START
OnLoop(function(myHero) -- myHero loop
	if(Config.W) then -- If W is enabled
		if(GetCurrentHP(myHero) <= 200 and Config.W) then -- Check HP
			CastSpell(_W) -- Cast W
		end -- End from HP check
	end -- End from W check
	
	if IWalkConfig.Combo then -- If Combo Key is pressed
		local Target = GetTarget(1500, DAMAGE_MAGIC) -- Get Target in 1500 Range
		if(ValidTarget(Target, 600)) then -- ValidTarget check
			if CanUseSpell(myHero, _Q) == READY and Config.Q then -- Check if Spell is useable
				CastTargetSpell(Target, _Q) -- Cast Q
				end -- End from Spell check
			end -- End from ValidTarget Check
		if(ValidTarget(Target, 1500)) then -- ValidTarget Check
			local EPrediction = GetPredictionForPlayer(GetMyHeroPos(),Target,GetMoveSpeed(Target),50,250,1500,80,false,false) -- Get Prediction
			if(CanUseSpell(myHero, _E) == READY and EPrediction.HitChance == 1 and Config.E) then -- Spell & Prediction Checks
				CastSkillShot(_E, EPrediction.PredPos.x, EPrediction.PredPos.y, EPrediction.PredPos.z) -- Cast E on predicted position
			end -- End from Spell & Prediction Checks
		end -- End from ValidTarget Check
		if(ValidTarget(Target, 700)) then -- ValidTarget check
			if CanUseSpell(myHero, _R) == READY and Config.R then -- Check if ult is up
				local UltDamage = 150 -- Ult Cast Damage lvl 1
				local OvertimeDamage = 15 -- Ult overtime Damage lvl 1
				if GetCastLevel(myHero, _R) == 2 then -- Ult lvl 2
					UltDamage = 250 -- adjust damage
					OvertimeDamage = 30 -- adjust damage
				elseif GetCastLevel(myHero, _R) == 3 then -- Ult lvl 3
					UltDamage = 350 -- adjust damage
					OvertimeDamage = 45 --adjust damage
					end -- End from Ult level check
				local Damage = UltDamage + (GetBonusAP(myHero) * 0.55) + 3 * (OvertimeDamage + (GetBonusAP(myHero) * 0.10)) -- Calculate Damage Ult (+55% ap) + 3x Overtime (+10% ap)
				if(GetCurrentHP(Target) - CalcDamage(myHero, Target, 0, Damage) <= 50) then -- Check if ult would kill him
					CastSkillShot(_R, GetOrigin(Target).x, GetOrigin(Target).y, GetOrigin(Target).z) -- Cast ult at Targets position
				end -- End from HP check
			end -- End from ult check
		end -- End from ValidTarget check
	end -- End from Combo Key check
	
	if IWalkConfig.Harass then -- If Harass Key is pressed
		local Target = GetTarget(1500, DAMAGE_MAGIC) -- Get Target in 1500 Range
		if(ValidTarget(Target, 600)) then -- ValidTarget check
			if CanUseSpell(myHero, _Q) == READY then -- Check if Spell is useable
				CastTargetSpell(Target, _Q) -- Cast Q
				end -- End from Spell check
			end -- End from ValidTarget Check
	end -- End from Harass key check
end) -- End from myHero loop
-- SCRIPT PART END
