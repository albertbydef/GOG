extends Node

var scorelvl1
var frutas
var health := 100
var maxHealth := 100
var flechas_fuego := 0
var flechas_hielo := 0
var flechas_electro := 0

#Desactivació nivells:
var begin := false
var final := true
var lvl1 := true
var lvl2 := true
var lvl3 := true
var lvl4 := true
var lvl5 := true
var lvl6 := true
var lvl7 := true
var lvl8 := true

#Vida maxima aconsseguida al nivell
var lvl1hp := false
var lvl2hp := false
var lvl3hp := false
var lvl4hp := false
var lvl5hp := false
var lvl6hp := false
var lvl7hp := false
var lvl8hp := false

#Settings
var fullscreen_on = true
var screen_res = 1
var sfx_vol = -10
var music_vol = -15
var master_vol = -10

func load_data():
	health = Save.game_data.HP
	maxHealth = Save.game_data.HPMAX
	flechas_fuego = Save.game_data.FLECHASFUEGO
	flechas_hielo = Save.game_data.FLECHASHIELO
	flechas_electro = Save.game_data.FLECHASELECTRO
	begin = Save.game_data.BEGIN
	final = Save.game_data.FINAL
	lvl1 = Save.game_data.LEVEL1
	lvl2 = Save.game_data.LEVEL2
	lvl3 = Save.game_data.LEVEL3
	lvl4 = Save.game_data.LEVEL4
	lvl5 = Save.game_data.LEVEL5
	lvl6 = Save.game_data.LEVEL6
	lvl7 = Save.game_data.LEVEL7
	lvl8 = Save.game_data.LEVEL8
	lvl1hp = Save.game_data.LEVEL1HP
	lvl2hp = Save.game_data.LEVEL2HP
	lvl3hp = Save.game_data.LEVEL3HP
	lvl4hp = Save.game_data.LEVEL4HP
	lvl5hp = Save.game_data.LEVEL5HP
	lvl6hp = Save.game_data.LEVEL6HP
	lvl7hp = Save.game_data.LEVEL7HP
	lvl8hp = Save.game_data.LEVEL8HP
	fullscreen_on = Save.game_data.FULLSCREEN_ON
	screen_res = Save.game_data.SCREEN_RES
	sfx_vol = Save.game_data.SFX_VOL
	music_vol = Save.game_data.MUSIC_VOL
	master_vol = Save.game_data.MASTER_VOL

func save_data():
	Save.game_data.HP = health
	Save.game_data.HPMAX = maxHealth
	Save.game_data.FLECHASFUEGO = flechas_fuego
	Save.game_data.FLECHASHIELO = flechas_hielo
	Save.game_data.FLECHASELECTRO = flechas_electro
	Save.game_data.BEGIN = begin
	Save.game_data.FINAL = final
	Save.game_data.LEVEL1 = lvl1
	Save.game_data.LEVEL2 = lvl2
	Save.game_data.LEVEL3 = lvl3
	Save.game_data.LEVEL4 = lvl4
	Save.game_data.LEVEL5 = lvl5
	Save.game_data.LEVEL6 = lvl6
	Save.game_data.LEVEL7 = lvl7
	Save.game_data.LEVEL8 = lvl8
	Save.game_data.LEVEL1HP = lvl1hp
	Save.game_data.LEVEL2HP = lvl2hp
	Save.game_data.LEVEL3HP = lvl3hp
	Save.game_data.LEVEL4HP = lvl4hp
	Save.game_data.LEVEL5HP = lvl5hp
	Save.game_data.LEVEL6HP = lvl6hp
	Save.game_data.LEVEL7HP = lvl7hp
	Save.game_data.LEVEL8HP = lvl8hp
	Save.game_data.FULLSCREEN_ON = fullscreen_on 
	Save.game_data.SCREEN_RES = screen_res 
	Save.game_data.SFX_VOL = sfx_vol 
	Save.game_data.MUSIC_VOL = music_vol 
	Save.game_data.MASTER_VOL = master_vol
