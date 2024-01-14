extends Node

var nextlevel = "res://Niveles/gaialvl_4_frozen_forest.tscn"
var actuallevel := 3
var scoreA = 5000
var scoreB = 2500

@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_victory: AudioStreamPlayer = $AudioStreamPlayerVictory

func _ready() -> void:
	canvas_layer_transition.get_child(1).play_backwards("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)

func _on_magic_fruit_body_entered(body: Node2D) -> void:
	if body is player:
		audio_stream_player.stop()
		audio_stream_player_victory.play()
		Global.lvl4 = false
		body.finishedLevel(actuallevel, nextlevel, scoreA, scoreB)


func _on_game_over_1_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().change_scene_to_file("res://Niveles/amor.tscn")
