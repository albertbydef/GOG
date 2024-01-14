extends Node

@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition

func _ready() -> void:
	$player.get_child(4).offset = Vector2(85,-85)
	$player.get_child(4).limit_right = 341
	$player.get_child(4).limit_top = 92
	canvas_layer_transition.get_child(1).play_backwards("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
