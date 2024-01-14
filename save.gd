extends Node

const SAVEFILE ="user://SAVEFILE.save"
var game_data = {
	"FLECHASHIELO" = 0,
	"FLECHASFUEGO" = 0,
	"FLECHASELECTRO" = 0,
	"HPMAX" = 100,
	"HP" = 100,
	#Activate Levels
	"BEGIN" = false,
	"FINAL" = true,
	"LEVEL1" = true,
	"LEVEL2" = true,
	"LEVEL3" = true,
	"LEVEL4" = true,
	"LEVEL5" = true,
	"LEVEL6" = true,
	"LEVEL7" = true,
	"LEVEL8" = true,
	#Max HP
	"LEVEL1HP" = false,
	"LEVEL2HP" = false,
	"LEVEL3HP" = false,
	"LEVEL4HP" = false,
	"LEVEL5HP" = false,
	"LEVEL6HP" = false,
	"LEVEL7HP" = false,
	"LEVEL8HP" = false,
	#SETTINGS
	"FULLSCREEN_ON" = true,
	"SCREEN_RES" = 1,
	"SFX_VOL" = -10,
	"MUSIC_VOL" = -15,
	"MASTER_VOL" = -10
	}
	

func load_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	file = null

func save_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(game_data)
	file = null
