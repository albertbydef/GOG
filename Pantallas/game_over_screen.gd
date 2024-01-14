extends CanvasLayer

@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition
@onready var audio_stream_player_menu_select: AudioStreamPlayer = $AudioStreamPlayerMenuSelect
@onready var audio_stream_player_confirm: AudioStreamPlayer = $AudioStreamPlayerConfirm
@onready var audio_stream_player_exit: AudioStreamPlayer = $AudioStreamPlayerExit


func _on_button_quit_pressed() -> void:
	audio_stream_player_exit.play()
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Pantallas/main_menu.tscn")


func _on_button_retry_pressed() -> void:
	audio_stream_player_confirm.play()
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_retry_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_quit_focus_entered() -> void:
	audio_stream_player_menu_select.play()
