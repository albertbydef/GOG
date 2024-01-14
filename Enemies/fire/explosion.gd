extends Area2D

var damage := 50
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_attack: AudioStreamPlayer2D = $AudioStreamPlayerAttack
var audioactive := false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio_stream_player_attack.play()
		body.takeDmg(damage)
		animated_sprite_2d.play("explosion")
		await (animated_sprite_2d.animation_finished)
		queue_free()
	if body.is_in_group("terreno"):
		audio_stream_player_attack.play()
		animated_sprite_2d.play("explosion")
		await (animated_sprite_2d.animation_finished)
		queue_free()
