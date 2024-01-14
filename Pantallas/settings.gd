extends VBoxContainer

@onready var check_box_fullscreen: CheckBox = $HBoxContainer/CheckBoxFullscreen
@onready var option_button_w_size: OptionButton = $HBoxContainer2/OptionButtonWSize
@onready var h_slider_sfx: HSlider = $HBoxContainer3/HSliderSFX
@onready var h_slider_music: HSlider = $HBoxContainer4/HSliderMusic
@onready var h_slider_master: HSlider = $HBoxContainer5/HSliderMaster
@onready var audio_stream_player_menu_select: AudioStreamPlayer = $AudioStreamPlayerMenuSelect
@onready var audio_stream_player_confirm: AudioStreamPlayer = $AudioStreamPlayerConfirm
@onready var audio_stream_player_exit: AudioStreamPlayer = $AudioStreamPlayerExit
@onready var audio_stream_player_atras: AudioStreamPlayer = $AudioStreamPlayerAtras


func _on_check_box_fullscreen_pressed() -> void:
	audio_stream_player_confirm.play()
	changeResolution()
	
func changeResolution():
	if check_box_fullscreen.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		option_button_w_size.disabled = true
	else:
		option_button_w_size.disabled = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	Global.fullscreen_on = check_box_fullscreen.button_pressed


func _on_option_button_w_size_item_selected(index: int) -> void:
	audio_stream_player_confirm.play()
	var size : Vector2
	
	match index:
		0:
			size = Vector2(640,360)
		1:
			size = Vector2(1280,720)
		2:
			size = Vector2(1920,1080)
		3:
			size = Vector2(3840,2160)
	DisplayServer.window_set_size(size)
	Global.screen_res = index


func _on_h_slider_sfx_value_changed(value: float) -> void:
	audio_stream_player_confirm.play()
	update_vol(1,value)

func _on_h_slider_music_value_changed(value: float) -> void:
	audio_stream_player_confirm.play()
	update_vol(2,value)


func _on_h_slider_master_value_changed(value: float) -> void:
	audio_stream_player_confirm.play()
	update_vol(0,value)

func update_vol(index, vol):
	AudioServer.set_bus_volume_db(index,vol)
	match index:
		0:
			Global.master_vol = vol
		1:
			Global.sfx_vol = vol
		2:
			Global.music_vol= vol


func _on_button_atras_pressed() -> void:
	audio_stream_player_exit.play()
	Global.save_data()
	Save.save_data()
	get_parent().get_child(2).show()
	hide()
	get_parent().get_child(2).get_child(0).grab_focus()


func _on_option_button_w_size_item_focused(index: int) -> void:
	audio_stream_player_menu_select.play()


func _on_check_box_fullscreen_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_option_button_w_size_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_h_slider_sfx_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_h_slider_music_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_h_slider_master_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_atras_focus_exited() -> void:
	audio_stream_player_menu_select.play()
