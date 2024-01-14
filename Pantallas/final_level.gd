extends CanvasLayer
var nextlevel : String
var flechas_fuego := 0
var flechas_hielo := 0
var flechas_electro := 0

@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition
@onready var audio_stream_player_menu_select: AudioStreamPlayer = $AudioStreamPlayerMenuSelect
@onready var audio_stream_player_confirm: AudioStreamPlayer = $AudioStreamPlayerConfirm
@onready var audio_stream_player_exit: AudioStreamPlayer = $AudioStreamPlayerExit
@onready var audio_stream_player_atras: AudioStreamPlayer = $AudioStreamPlayerAtras



func _on_button_next_level_pressed() -> void:
	audio_stream_player_confirm.play()
	saveLevel()
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file(nextlevel)
	


func _on_button_retry_pressed() -> void:
	audio_stream_player_confirm.play()
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_button_quit_pressed() -> void:
	audio_stream_player_exit.play()
	saveLevel()
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Pantallas/main_menu.tscn")

func saveLevel():
	Global.flechas_hielo = flechas_hielo
	Global.flechas_fuego = flechas_fuego
	Global.flechas_electro = flechas_electro
	Global.save_data()
	Save.save_data()
	

func scorelvl(score, scoreA, scoreB):
	$VBoxContainer/HBoxContainer/LabelScore.text = str(score)
	if score >= scoreA:
		$VBoxContainer/HBoxContainer2/LabelNoteA.show()
	if score < scoreA and score >= scoreB:
		$VBoxContainer/HBoxContainer2/LabelRateB.show()
	if score < scoreB:
		$VBoxContainer/HBoxContainer2/LabelRateC.show()

func awards(maxhealth, flechasfuego, flechashielo, flechaselectro):
	$VBoxContainer/VBoxContainer.show()
	if maxhealth > 0:
		$VBoxContainer/VBoxContainer/HBoxContainer/TextureRectHealth.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumHealth.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumHealth.text = "+"+str(maxhealth)
	if flechasfuego > 0:
		$VBoxContainer/VBoxContainer/HBoxContainer/TextureRectFireArrow.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumFireArrow.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumFireArrow.text = str(flechasfuego)
	if flechashielo > 0:
		$VBoxContainer/VBoxContainer/HBoxContainer/TextureRectIceArrow.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumIceArrow.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumIceArrow.text = str(flechashielo)
	if flechaselectro > 0:
		$VBoxContainer/VBoxContainer/HBoxContainer/TextureRectElectroArrow.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumElectroArrow.show()
		$VBoxContainer/VBoxContainer/HBoxContainer/LabelNumElectroArrow.text = str(flechaselectro)
	
	


func _on_button_next_level_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_retry_focus_entered() -> void:
	audio_stream_player_menu_select.play()


func _on_button_quit_focus_entered() -> void:
	audio_stream_player_menu_select.play()
