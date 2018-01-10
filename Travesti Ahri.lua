class "Ahri"



        -- O N  C L A S S  L O A D :

                function Ahri:__init()

                        require("OpenPredict")

                        require("DamageLib")
                        
                        require("Inspired")
                                
                        version = "1.0"

                        self:Update()

                        focus_target = nil

                        last_q = 0

                        last_w = 0

                        last_e = 0

                        last_r = 0

                        ignite = nil

                        qinfo = { width = 100, delay = 0.25, speed = 1700, range = 850 }

                        einfo = { width = 60, delay = 0.25, speed = 1600, range = 935 }

                        lvlup= { _Q, _E, _Q, _W, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E }

                        OnTick(function(myHero) self:Tick() end)

                        OnWndMsg(function(msg, key) self:Msg(msg, key) end)

                        OnLoad(function() self:Load() end)

                        OnDraw(function() self:Draw() end)

                        OnSpellCast(function(spell) self:Cast(spell) end)

                end





        -- C O M B O :

                function Ahri:Combo()

                        local etarget = Ahri:GetTarget(menu.com.eset.eran:Value())

                        if etarget ~= nil then

                                self:CastE(etarget, menu.com.eset.ehit:Value()/100)

                                if GetTickCount() > last_r + 1150 then

                                        self:CastR(etarget, menu.com.rset.mode:Value(), menu.com.rset.modee:Value())

                                end

                        end

                        local qtarget = Ahri:GetTarget(menu.com.qset.qran:Value())

                        if qtarget ~= nil then

                                self:CastQ(qtarget, menu.com.qset.qhit:Value()/100)

                        end

                        local wtarget = Ahri:GetTarget(menu.com.wset.wran:Value())

                        if wtarget ~= nil then

                                self:CastW(wtarget)

                        end

                end








        -- Q  L O G I C :

                function Ahri:CastQ(unit, hitchance)

                        if Ready(_Q) then

                                local qp = GetPrediction(unit, qinfo)

                                if qp and qp.hitChance >= menu.com.qset.qhit:Value()/100 then

                                        CastSkillShot(_Q, qp.castPos)

                                end

                        end

                end






        -- W  L O G I C :

                function Ahri:CastW(unit)

                        if Ready(_W) and GetDistance(myHero, unit) < 550 then

                                CastSpell(_W)

                        end

                end






        -- E  L O G I C :

                function Ahri:CastE(unit, hitchance)

                        if Ready(_E) then

                                local ep = GetPrediction(unit, einfo)

                                if ep and ep.hitChance >= hitchance and not ep:mCollision(1) then

                                        CastSkillShot(_E, ep.castPos)

                                end

                        end

                end




        -- R  L O G I C :

                function Ahri:ExtendedMousePos(range)

                        local a = myHero.pos

                        local b = GetMousePos()

                        local ab = math.sqrt((a.x-b.x)*(a.x-b.x)+(a.z-b.z)*(a.z-b.z))

                        local dir = { x = (b.x-a.x)/ab, z = (b.z-a.z)/ab }

                        return { x = a.x + ( dir.x * range ), z = a.z + ( dir.z * range ) }

                end

                function Ahri:MinimumEnemies(pos)

                        local count = 0

                        for i, enemy in pairs(GetEnemyHeroes()) do

                                if ValidTarget(enemy, 1200) then

                                        local a = pos

                                        local b = enemy.pos

                                        local ab = math.sqrt((a.x - b.x) * (a.x - b.x) + (a.z - b.z) * (a.z - b.z))

                                        if ab < 750 then

                                                count = count + 1

                                        end

                                end

                        end

                        return count

                end

                function Ahri:PosOnPerpendicular(a, b, distance)

                        local vx = a.x - b.x

                        local vz = a.z - b.z

                        local vxz = math.sqrt(vx*vx+vz*vz)

                        local p1 = { x = vx / vxz * distance, z = - vz / vxz * distance }

                        local c1 = self:MinimumEnemies(p1)

                        if c1 == 0 then

                                return p1

                        end

                        local p2 = { x = vx / vxz * distance, z = -vz / vxz * -distance }

                        local c2 = self:MinimumEnemies(p2)

                        if c2 == 0 then

                                return p2

                        end

                        if c1 > c2 then

                                return p2

                        else

                                return p1

                        end

                end

                function Ahri:SafePos(a, b, safedist)

                        local ran = math.random( 250, 425)

                        local p = self:PosOnPerpendicular(a, b, ran)

                        local pb = math.sqrt((b.x-p.x)*(b.x-p.x)+(b.z-p.z)*(b.z-p.z))

                        local dir = { x = ( p.x - b.x ) / pb, z = ( p.z - b.z ) / pb }

                        return { x = b.x + ( dir.x * safedist ), z = b.z + ( dir.z * safedist ) }

                end

                function Ahri:CastR(unit, mode, modee)

                        if Ready(_R) and menu.com.rset.a:Value() and unit ~= nil then

                                if mode == 1 then

                                        if modee == 1 then

                                                local pos = self:ExtendedMousePos(425)

                                                CastSkillShot(_R, pos)

                                        end

                                        if modee == 2 then

                                                if self:CalculateDmg(unit) > unit.health then

                                                        local pos = self:ExtendedMousePos(425)

                                                        CastSkillShot(_R, pos)

                                                end

                                        end

                                end

                                if mode == 2 then

                                        if modee == 1 then

                                                if unit.health > 500 then

                                                        local a = myHero.pos

                                                        local b = unit.pos

                                                        local safepos = self:SafePos(a, b, menu.com.rset.sran:Value())

                                                        CastSkillShot(_R, safepos)

                                                else

                                                        local pos = self:ExtendedMousePos(425)

                                                        CastSkillShot(_R, pos)

                                                end

                                        end

                                        if modee == 2 then

                                                if self:CalculateDmg(unit) > unit.health then

                                                        if unit.health > 500 then

                                                                local a = myHero.pos

                                                                local b = unit.pos

                                                                local safepos = self:SafePos(a, b, menu.com.rset.sran:Value())

                                                                CastSkillShot(_R, safepos)

                                                        else

                                                                local pos = self:ExtendedMousePos(425)

                                                                CastSkillShot(_R, pos)

                                                        end

                                                end

                                        end

                                end

                        end

                end

                function Ahri:CalculateDmg(unit)

                        local dmg = 0

                        if Ready(_Q) or (GetDistance(myHero, unit) < 900 and GetTickCount() < last_q + 500) then

                                dmg = dmg + getdmg("Q",unit, myHero, 3)

                        end

                        if Ready(_W) or (GetDistance(myHero, unit) < 900 and GetTickCount() < last_w + 500) then

                                dmg = dmg + getdmg("W",unit, myHero, 3)

                        end

                        if Ready(_E) or (GetDistance(myHero, unit) < 900 and GetTickCount() < last_e + 500) then

                                dmg = dmg + getdmg("E",unit, myHero, 3)

                        end

                        if Ready(_R) or (GetDistance(myHero, unit) < 900 and GetTickCount() < last_r + 500) then

                                dmg = dmg + getdmg("R",unit, myHero, 3)*3

                        end

                        if ignite ~= nil and Ready(ignite) then

                                dmg = dmg + 50 + (20 * myHero.level)

                        end

                        dmg = dmg + myHero.totalDamage*3

                        return dmg

                end







        -- I G N I T E :

                function Ahri:CastIgnite()

                        if Ready(ignite) then

                                for i, enemy in pairs(GetEnemyHeroes()) do

                                        if ValidTarget(enemy, r) and menu.ign.on[enemy.charName]:Value() then

                                                if enemy.health < 50 + (20 * myHero.level) then

                                                        CastTargetSpell(enemy, ignite)

                                                end

                                        end

                                end

                        end

                end






        -- L E V E L  U P :

                function Ahri:LevelUp()

                        if GetLevelPoints(myHero) ~= 0 then

                                DelayAction(function() LevelSpell(lvlup[GetLevel(myHero)]) end, math.random(1.247,1.742))

                        end

                end






        -- T A R G E T  S E L E C T O R :

                function Ahri:GetTarget(r)

                        local t = nil

                        num = 10000

                        for i, enemy in pairs(GetEnemyHeroes()) do

                                local name = enemy.charName

                                if ValidTarget(enemy, r) and menu.ts.f[name]:Value() then

                                        if enemy.health < num then

                                                num = enemy.health

                                                t = enemy

                                        end

                                end

                        end

                        if self.focus_target ~= nil and ValidTarget(self.focus_target, r) then

                                t = self.focus_target

                        end

                        return t

                end






        -- L A N E  C L E A R :

                function Ahri:BestLaneClearMinion()

                        local minion = nil

                        local count = 0

                        for i, m in pairs(minionManager.objects) do

                                if ValidTarget(m, 880) then

                                        local c = self:CollisionCount(myHero.pos, m.pos, 200, 880)

                                        if c > count then

                                                count = c

                                                minion = m

                                        end

                                end

                        end

                        return minion

                end

                function Ahri:CollisionCount(a, b, h, r)

                        count = 0

                        for i, minion in pairs(minionManager.objects) do

                                if ValidTarget(minion, r) and self:Collision(a, b, minion, h) then

                                        count = count + 1

                                end

                        end

                        return count

                end

                function Ahri:Collision(a, b, c, h)

                        local abz = b.z-a.z

                        local abx = b.x-a.x

                        local acx = a.x-c.x

                        local acz = c.z-a.z

                        local ab = math.sqrt((a.x - b.x) * (a.x - b.x) + (a.z - b.z) * (a.z - b.z))

                        local ac = math.sqrt((a.x - c.x) * (a.x - c.x) + (a.z - c.z) * (a.z - c.z))

                        local bc = math.sqrt((c.x - b.x) * (c.x - b.x) + (c.z - b.z) * (c.z - b.z))

                        if ac < ab + 100 and  bc < ab + 200 then

                                local dist_obj_line = math.abs(abz * acx + abx * acz) / ab

                                if dist_obj_line < h then

                                        return true

                                else

                                        return false

                                end

                        else

                                return false

                        end

                end

                function Ahri:LaneClear()

                        if menu.lan.useqc:Value() then

                                if Ready(_Q) then

                                        local target = Ahri:GetTarget(menu.har.qran:Value())

                                        if target ~= nil then

                                                self:CastQ(target, menu.lan.qh:Value()/100)

                                        end

                                end

                        end

                        if menu.lan.useq:Value() then

                                if Ready(_Q) and myHero.mana >= myHero.maxMana * menu.lan.mman:Value() / 100 then

                                        local minion = self:BestLaneClearMinion()

                                        if minion ~= nil then

                                                CastSkillShot(_Q, minion.pos)

                                        end

                                end

                        end

                        if menu.lan.usew:Value() then

                                if Ready(_W) and myHero.mana >= myHero.maxMana * menu.lan.mman:Value() / 100 then

                                        for i, minion in pairs(minionManager.objects) do

                                                if ValidTarget(minion, 550) then

                                                        CastSpell(_W)

                                                end

                                        end

                                end

                        end

                end




        -- H A R A S S :

                function Ahri:Harass()

                        if myHero.mana > myHero.maxMana * menu.har.mman:Value()/100 then

                                local range = 0

                                if menu.har.usee:Value() and Ready(_E) then

                                        range = menu.har.eran:Value()

                                elseif menu.har.useq:Value() and Ready(_Q) then

                                        range = menu.har.qran:Value()

                                elseif menu.har.usew:Value() and Ready(_W) then

                                        range = menu.har.wran:Value()

                                end

                                local target = Ahri:GetTarget(range)

                                if target ~= nil then

                                        if menu.har.usee:Value() then

                                                self:CastE(target, menu.har.hit:Value()/100)

                                        end

                                        if menu.har.useq:Value() then

                                                self:CastQ(target, menu.har.hit:Value()/100)

                                        end

                                        if menu.har.usew:Value() and GetDistance(target, myHero) < 550 then

                                                self:CastW(target)

                                        end

                                        if GetTickCount() > last_r + 1150 then

                                                self:CastR(target, menu.com.rset.mode:Value(), menu.com.rset.modee:Value())

                                        end

                                end

                        end

                end









        -- E V E N T S :

                function Ahri:Cast(spell)

                        if GetTickCount() > last_q + 1000 and spell.spellID == _Q then

                                last_q = GetTickCount()

                        end

                        if GetTickCount() > last_w + 1000 and spell.spellID == _W then

                                last_w = GetTickCount()

                        end

                        if GetTickCount() > last_e + 1000 and spell.spellID == _E then

                                last_e = GetTickCount()

                        end

                        if GetTickCount() > last_r + 1000 and spell.spellID == _R then

                                last_r = GetTickCount()

                        end

                end

                function Ahri:Msg(msg, key)

                        if key == 1 and menu.ts.m.a:Value() then

                                local obj = nil

                                for i, enemy in ipairs(GetEnemyHeroes()) do

                                        if ValidTarget(enemy, 2500) then

                                          local mp = GetMousePos()

                                          local ep = enemy.pos

                                                local dist = math.sqrt((ep.x - mp.x)*(ep.x - mp.x)+(ep.z- mp.z)*(ep.z - mp.z))

                                                if dist < 150 then

                                                        obj = enemy

                                                        break

                                                end

                                        end

                                end

                                self.focus_target = obj

                        end

                end

                function Ahri:Tick()

                        self:Automatic()

                        if menu.har.hkey:Value() then

                                self:Harass()

                        end

                        if menu.com.ckey:Value() then

                                self:Combo()

                        end

                        if menu.lan.lkey:Value() then

                                self:LaneClear()

                        end

                end

                function Ahri:Load()

                        self.CreateMenu()

                        if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then

                                ignite = SUMMONER_1

                        elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then

                                ignite = SUMMONER_2

                        end

                end

                function Ahri:Draw()

                        if menu.ts.d.a:Value() then

                                local range = 0

                                if Ready(_E) then

                                        range = menu.com.eset.eran:Value()

                                elseif Ready(_Q) then

                                        range = menu.com.qset.qran:Value()

                                elseif Ready(_W) then

                                        range = menu.com.wset.wran:Value()

                                end

                                local t = self:GetTarget(range)

                                if t ~= nil then

                                        DrawCircle(t.pos, 125, 1, 1, menu.ts.d.c:Value())

                                end

                        end

                end







        -- O T H E R  F U N C T I O N S :

                function Ahri:Automatic()

                        self:Checks()

                        if menu.ign.a:Value() then

                                self.CastIgnite()

                        end

                        if menu.lvl.a:Value() then

                                self.LevelUp()

                        end
                end

                function Ahri:Checks()

                        if qinfo.range ~=menu.com.qset.qran:Value() then

                                qinfo.range = menu.com.qset.qran:Value()

                        end

                        if einfo.range ~=menu.com.eset.eran:Value() then

                                einfo.range = menu.com.eset.eran:Value()

                        end

                end

                function Ahri:CreateMenu()

                        menu = MenuConfig("Travesti", "Travesti Ahri")

                                menu:SubMenu("ts", "Target Selector")

                                        menu.ts:SubMenu("f", "Focus List")

                                                for i, enemy in ipairs(GetEnemyHeroes()) do

                                                        menu.ts.f:Boolean(enemy.charName, enemy.charName, true)

                                                end

                                        menu.ts:SubMenu("m", "Manual Target Selector (Left mouse)")

                                                menu.ts.m:Boolean("a", "Active", true)

                                        menu.ts:SubMenu("d", "Draws")

                                                menu.ts.d:Boolean("a", "Active", true)

                                                menu.ts.d:ColorPick("c", "Current Target", {255,255,0,0})

                                menu:SubMenu("com", "Combo")

                                        menu.com:KeyBinding("ckey", "Key", string.byte(" "))

                                        menu.com:SubMenu("qset", "Q Settings")

                                                menu.com.qset:Slider("qran", "Range: ", 800, 500, 880)

                                                menu.com.qset:Slider("qhit", "Hitchance Percent: ", 55, 1, 99)

                                        menu.com:SubMenu("wset", "W Settings")

                                                menu.com.wset:Slider("wran", "Range: ", 550, 300, 550)

                                        menu.com:SubMenu("eset", "E Settings")

                                                menu.com.eset:Slider("eran", "Range: ", 900, 500, 975)

                                                menu.com.eset:Slider("ehit", "Hitchance Percent: ", 55, 1, 99)

                                        menu.com:SubMenu("rset", "R Settings")

                                                menu.com.rset:Boolean("a", "Active", true)

                                                menu.com.rset:DropDown("mode", "First Settings", 2, {"To Mouse", "Safe"})

                                                menu.com.rset:DropDown("modee", "Second Settings", 2, {"Always", "Only If Killable [dmg calc Q, W, E, R, AA]"})

                                                menu.com.rset:Slider("sran", "Safe Mode: Distance: ", 475, 100, 575)

                                menu:SubMenu("har", "Harass")

                                        menu.har:KeyBinding("hkey", "Key", string.byte("C"))

                                        menu.har:Slider("mman", "Min. Mana Percent: ", 50, 0, 100)

                                        menu.har:Slider("hit", "Hitchance Percent Q and E: ", 75, 1, 99)

                                        menu.har:Boolean("useq", "Use Q", true)

                                        menu.har:Slider("qran", "Q Range: ", 800, 500, 880)

                                        menu.har:Boolean("usew", "Use W", false)

                                        menu.har:Slider("wran", "W Range: ", 475, 400, 550)

                                        menu.har:Boolean("usee", "Use E", false)

                                        menu.har:Slider("eran", "E Range: ", 900, 500, 975)

                                menu:SubMenu("lan", "Lane Clear")

                                        menu.lan:KeyBinding("lkey", "Key", string.byte("V"))

                                        menu.lan:Slider("mman", "Min. Mana Percent: ", 50, 0, 100)

                                        menu.lan:Slider("qh", "Hitchance Percent Q on Champions: ", 75, 1, 99)

                                        menu.lan:Boolean("useqc", "Use Q On Champions", true)

                                        menu.lan:Boolean("useq", "Use Q", false)

                                        menu.lan:Boolean("usew", "Use W", false)

                                menu:SubMenu("ign", "Ignite")

                                        menu.ign:Boolean("a", "Active", true)

                                        menu.ign:SubMenu("on", "Ignite on:")

                                                for i, enemy in ipairs(GetEnemyHeroes()) do

                                                        menu.ign.on:Boolean(enemy.charName, enemy.charName, true)

                                                end

                                menu:SubMenu("lvl", "AutoLevelUp")

                                        menu.lvl:Boolean("a", "Active", false)
                end












-- I N I T I A L I Z E  C L A S S :

        _G[GetObjectName(myHero)]()
