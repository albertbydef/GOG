extends Node

@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition

func _ready() -> void:
	canvas_layer_transition.get_child(1).play_backwards("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	$Timer.start() 
func _on_timer_timeout() -> void:
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	Global.lvl1 = false
	Global.save_data()
	Save.save_data()
	get_tree().change_scene_to_file("res://Niveles/savage_forest.tscn")
