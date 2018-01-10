LuxMenu = Menu("Travesti Lux", "Travesti Lux:")
LuxMenu:SubMenu("Combo", "Combo")
LuxMenu.Combo:Boolean("Q", "Use Q", true)
LuxMenu.Combo:Boolean("E", "Use E", true)
LuxMenu.Combo:Boolean("AW", "Use Ally W", true)
LuxMenu.Combo:Boolean("MW", "Use Me W", true)

LuxMenu:SubMenu("Killsteal", "Killsteal")
LuxMenu.Killsteal:Boolean("R", "Killsteal with R", true)
LuxMenu.Killsteal:Boolean("E", "Killsteal with E", true)


LuxMenu:SubMenu("Drawings", "Drawings:")
LuxMenu.Drawings:Boolean("Q", "Draw Q", true)
LuxMenu.Drawings:Boolean("W", "Draw W", true)
LuxMenu.Drawings:Boolean("E", "Draw E", true)
LuxMenu.Drawings:Boolean("R", "Draw R", true)


LuxMenu:SubMenu("DMG", "Draw DMG")
LuxMenu.DMG:Boolean("Q", "Draw Q Dmg", true)
LuxMenu.DMG:Boolean("E", "Draw E Dmg", true)
LuxMenu.DMG:Boolean("R", "Draw R Dmg", true)



OnLoop(function(myHero)





if IOW:Mode() == "Combo" then


local target = GetCurrentTarget()


				local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,250,1300,70,true,false)
        local EPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1300,250,1100,300,false,false)
        local RPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),0,1000,3500,110,false,false)





                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_Q)) and LuxMenu.Combo.Q:Value() then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
					           	end
                      for _, ally in pairs(GoS:GetAllyHeroes()) do
                        local WPred = GetPredictionForPlayer(GoS:myHeroPos(),ally,GetMoveSpeed(ally),1600,250,1050,80,false,false)
                        if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and (GetCurrentHP(ally)/GetMaxHP(ally))<0.5 and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and GoS:GetDistance(myHero, ally) <= 1050 and LuxMenu.Combo.AW:Value() then
                           CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                         end
                       end
                       local WPred = GetPredictionForPlayer(GoS:myHeroPos(),myHero,GetMoveSpeed(myHero),1600,250,1050,80,false,false)
                      if CanUseSpell(myHero, _W) == READY and WPred.HitChance == 1 and (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.5 and GoS:ValidTarget(target, GetCastRange(myHero,_W)) and LuxMenu.Combo.MW:Value() then
                        CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
                     end
                        if CanUseSpell(myHero, _E) == READY and EPred.HitChance == 1 and GoS:ValidTarget(target, GetCastRange(myHero,_E)) and LuxMenu.Combo.E:Value() then
                        CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
						end
        end




for i,enemy in pairs(GoS:GetEnemyHeroes()) do

  if CanUseSpell(myHero,_Q) == READY and LuxMenu.DMG.Q:Value() and GoS:ValidTarget(enemy, 2000) then
local trueDMG = GoS:CalcDamage(myHero, enemy, 0, (50*GetCastLevel(myHero,_Q) + 10 + 0.7*(GetBonusAP(myHero))))
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),trueDMG,0,0xff0cff00)
    elseif CanUseSpell(myHero,_E) == READY and LuxMenu.DMG.E:Value() and GoS:ValidTarget(enemy, 2000) then
local trueDMG = GoS:CalcDamage(myHero, enemy, 0, (45*GetCastLevel(myHero,_E) + 15 + 0.6*(GetBonusAP(myHero))))
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),trueDMG,0,0xff0cff00)
    elseif CanUseSpell(myHero,_R) == READY and LuxMenu.DMG.R:Value() and GoS:ValidTarget(enemy, GetCastRange(myHero,_R)) then
local trueDMG = GoS:CalcDamage(myHero, enemy, 0, (100*GetCastLevel(myHero,_R) + 200 + 0.75*(GetBonusAP(myHero))))
    DrawDmgOverHpBar(enemy,GetCurrentHP(enemy),trueDMG,0,0xff0cff00)
    end


 end



for i,enemy in pairs(GoS:GetEnemyHeroes()) do

local RPred = GetPredictionForPlayer(Gos:myHeroPos(),enemy,GetMoveSpeed(enemy),0,1200,3500,190,false,false)

 	           if CanUseSpell(myHero, _E) == READY and RPred.HitChance == 1 and GoS:ValidTarget(enemy, 2000) (myHero,_E)) and LuxMenu.Killsteal.E:Value() and GetCurrentHP(enemy) < GoS:CalcDamage(myHero,  enemy, 0, (*GetCastLevel(myHero,_E) + 45 + 0.60*(GetBonusAP(myHero)))) then
              CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
             end
      end


  	           if CanUseSpell(myHero, _R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(enemy,GetCastRange(myHero,_R)) and LuxMenu.Killsteal.R:Value() and GetCurrentHP(enemy) < GoS:CalcDamage(myHero,  enemy, 0, (100*GetCastLevel(myHero,_R) + 200 + 0.75*(GetBonusAP(myHero)))) then
              CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
             end
      end

if LuxMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if LuxMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff00ff00) end
if LuxMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
if LuxMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff00ff00) end

end)
