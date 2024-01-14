extends VBoxContainer

@onready var audio_stream_player_menu_select: AudioStreamPlayer = $AudioStreamPlayerMenuSelect
@onready var audio_stream_player_confirm: AudioStreamPlayer = $AudioStreamPlayerConfirm
@onready var audio_stream_player_exit: AudioStreamPlayer = $AudioStreamPlayerExit
@onready var audio_stream_player_atras: AudioStreamPlayer = $AudioStreamPlayerAtras


func  levels():
	$HBoxContainer/VBoxContainerMidtown/ButtonBegin.disabled = Global.begin
	$HBoxContainer/VBoxContainerMidtown/ButtonFinal.disabled = Global.final
	$"HBoxContainer/VBoxContainerForestLevels/ButtonNivel 1".disabled = Global.lvl1
	$"HBoxContainer/VBoxContainerForestLevels/ButtonNivel 2".disabled = Global.lvl2
	$"HBoxContainer/VBoxContainerForestLevels/ButtonNivel 3".disabled = Global.lvl3
	$"HBoxContainer/VBoxContainerFrozenForestLevels/ButtonNivel 4".disabled = Global.lvl4
	$"HBoxContainer/VBoxContainerFrozenForestLevels/ButtonNivel 5".disabled = Global.lvl5
	$"HBoxContainer/VBoxContainerFrozenForestLevels/ButtonNivel 6".disabled = Global.lvl6
	$"HBoxContainer/VBoxContainerDesertLevels/ButtonNivel 7".disabled = Global.lvl7
	$"HBoxContainer/VBoxContainerDesertLevels/ButtonNivel 8".disabled = Global.lvl8

func _on_button_begin_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/intro.tscn")


func _on_button_final_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/mid_town_final.tscn")


func _on_button_nivel_1_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_1Forest.tscn")


func _on_button_nivel_2_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_2_forest.tscn")


func _on_button_nivel_3_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_3_forest.tscn")


func _on_button_nivel_4_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_4_frozen_forest.tscn")


func _on_button_nivel_5_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_5_frozen_forest.tscn")


func _on_button_nivel_6_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_6_frozen_forest.tscn")


func _on_button_nivel_7_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_7_desert.tscn")


func _on_button_nivel_8_pressed() -> void:
	audio_stream_player_confirm.play()
	get_tree().change_scene_to_file("res://Niveles/gaialvl_8_desert.tscn")


func _on_button_atras_pressed() -> void:
	audio_stream_player_exit.play()
	get_parent().get_child(2).show()
	hide()
	get_parent().get_child(2).get_child(0).grab_focus()




func _on_button_begin_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_final_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_1_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_2_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_3_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_4_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_5_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_6_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_7_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_nivel_8_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_atras_focus_entered() -> void:
	audio_stream_player_menu_select.play()
