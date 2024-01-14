extends Node

@onready var v_box_container_levels: VBoxContainer = $VBoxContainerLevels
@onready var v_box_container_menu: VBoxContainer = $VBoxContainerMainMenu
@onready var v_box_container_settings: VBoxContainer = $VBoxContainerSettings
@onready var canvas_layer_tutorial: CanvasLayer = $CanvasLayerTutorial
@onready var audio_stream_player_menu_select: AudioStreamPlayer = $AudioStreamPlayerMenuSelect
@onready var audio_stream_player_confirm: AudioStreamPlayer = $AudioStreamPlayerConfirm
@onready var audio_stream_player_exit: AudioStreamPlayer = $AudioStreamPlayerExit
@onready var audio_stream_player_music: AudioStreamPlayer = $AudioStreamPlayerMusic


func _ready() -> void:
	Save.load_data()
	Global.load_data()
	v_box_container_settings.get_child(1).get_child(1).button_pressed = Global.fullscreen_on
	v_box_container_settings.changeResolution()
	v_box_container_settings.get_child(4).get_child(1).value = Global.sfx_vol
	v_box_container_settings.get_child(5).get_child(1).value = Global.music_vol
	v_box_container_settings.get_child(6).get_child(1).value = Global.master_vol
	v_box_container_settings.get_child(2).get_child(1).selected = Global.screen_res
	v_box_container_settings._on_option_button_w_size_item_selected(Global.screen_res)
	$VBoxContainerMainMenu/ButtonStartGame.grab_focus()


func _on_exit_pressed() -> void:
	audio_stream_player_exit.play()
	await (audio_stream_player_exit.finished)
	get_tree().quit()



func _on_button_settings_pressed() -> void:
	audio_stream_player_confirm.play()
	v_box_container_menu.hide()
	v_box_container_settings.show()
	v_box_container_settings.get_child(1).get_child(1).grab_focus()


func _on_button_tutorial_pressed() -> void:
	audio_stream_player_confirm.play()
	canvas_layer_tutorial.show()
	canvas_layer_tutorial.get_child(0).get_child(0).get_child(2).play()
	canvas_layer_tutorial.get_child(0).get_child(0).get_child(3).grab_focus()



func _on_button_start_game_pressed() -> void:
	audio_stream_player_confirm.play()
	v_box_container_menu.hide()
	v_box_container_levels.levels()
	v_box_container_levels.show()
	v_box_container_levels.get_child(0).get_child(0).get_child(1).grab_focus()
	print(Global.lvl1)
	


func _on_button_start_game_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_settings_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_tutorial_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_exit_focus_exited() -> void:
	audio_stream_player_menu_select.play()
