require('Inspired')
require('Interrupter')
require('IPrediction')
require('OpenPredict')

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

-- Yasuo

local YasuoQ = { range = 475, radius = 40, speed = math.huge, delay = 0.25, type = "line", col = {"yasuowall"}, collision = false, source = myHero }
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
	if GetDistance(target) < YasuoQ.range then
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
			useQ(target)
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
					if GetDistance(target) < YasuoE.range+50 and GetDistance(target) > YasuoE.range-50 then
						useE(target)
					elseif GetDistance(target) < YasuoE.range+1000 and GetDistance(target) >= YasuoE.range+50 then
						for _, minion in pairs(minionManager.objects) do
							if GetTeam(minion) == MINION_ENEMY and GetDistance(minion) <= 475 then
								EPos = myHero+(Vector(minion)-myHero):normalized()*YasuoE.range
								if GetDistance(EPos, target) < GetDistance(minion, target) then
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
					if GetDistance(target) < YasuoE.range+50 and GetDistance(target) > YasuoE.range-50 then
						useE(target)
					elseif GetDistance(target) < YasuoE.range+1000 and GetDistance(target) >= YasuoE.range+50 then
						for _, minion in pairs(minionManager.objects) do
							if GetTeam(minion) == MINION_ENEMY and GetDistance(minion) <= 475 then
								EPos = myHero+(Vector(minion)-myHero):normalized()*YasuoE.range
								if GetDistance(EPos, target) < GetDistance(minion, target) then
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
	if Mode() == "Combo" or Mode() == "Harass" then
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

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01 Yasuo<font color='#1E90FF'>] <font color='#00BFFF'>v1.0.6")
-- 1.0.6
-- + Added E wrap checking
-- + Experimental improvement for E logic
-- 1.0.5
-- + Minor changes
-- 1.0.4
-- + Added Interrupter
-- + Fixed LaneClear & JungleClear mode (use LaneClear key)
-- 1.0.3
-- + Fixed bug with spell detection
-- 1.0.2
-- + Fixed bug with Harass mode
-- 1.0.1
-- + Improved spell database for Yasuo's W
-- 1.0
-- + Initial release