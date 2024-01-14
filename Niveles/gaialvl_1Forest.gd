extends Node

var nextlevel := "res://Niveles/gaialvl_2_forest.tscn"
var actuallevel := 1
var scoreA := 5000
var scoreB := 2500

@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_victory: AudioStreamPlayer = $AudioStreamPlayerVictory

func _ready() -> void:
	canvas_layer_transition.get_child(1).play_backwards("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)

func _on_final_level_body_entered(body: Node2D) -> void:
	if body is player:
		audio_stream_player.stop()
		audio_stream_player_victory.play()
		Global.lvl2 = false
		body.finishedLevel(actuallevel, nextlevel, scoreA, scoreB)


func _on_game_over_1_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)


func _on_game_over_2_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)


func _on_game_over_3_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)


func _on_game_over_4_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(9999)
