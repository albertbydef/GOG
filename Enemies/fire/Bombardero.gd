extends CharacterBody2D

var direccion := -1
var speed := 30
enum estados {PATRULLAR, BOMBARDEANDO, MUERTO}
var estadoActual = estados.PATRULLAR

var oneshot = false
var is_bombing = false

var health := 20:
	set(val):
		health = val
		$TextureProgressBarHP.value = val
var damage := 10
var score := 800
var audioactive := false
signal audioarea

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hurt_timer: Timer = $HurtTimer
@onready var change_dir_timer: Timer = $ChangeDirTimer
@onready var bomb_timer: Timer = $BombTimer
@onready var origen_bomb_marker_2d: Marker2D = $OrigenBombMarker2D
@onready var audio_stream_player_dead: AudioStreamPlayer = $AudioStreamPlayerDead
@onready var audio_stream_player_attack: AudioStreamPlayer2D = $AudioStreamPlayerAttack
@onready var audio_stream_player_hurt: AudioStreamPlayer = $AudioStreamPlayerHurt
@onready var texture_progress_bar_hp: TextureProgressBar = $TextureProgressBarHP


var bomb = preload("res://Enemies/fire/bomb.tscn")

func _ready() -> void:
	texture_progress_bar_hp.max_value = health

func _physics_process(delta: float) -> void:
	if estadoActual == estados.PATRULLAR:
		animated_sprite_2d.play("moving")
		velocity.x = direccion * speed
		move_and_slide()
	if estadoActual == estados.BOMBARDEANDO and !is_bombing:
		bomb_timer.paused = true
		is_bombing = true
		animated_sprite_2d.play("lose_bomb")
		bombAttack()
		await (animated_sprite_2d.animation_finished)
		estadoActual = estados.PATRULLAR
		bomb_timer.paused = false
		is_bombing = false
		

func _process(delta: float) -> void:
	animated_sprite_2d.flip_h = true if direccion == 1 else false
	collision_shape_2d.scale.x = -0.1 if direccion == 1 else 0.1

func bombAttack():
	audio_stream_player_attack.play()
	var bombing = bomb.instantiate()
	if !oneshot:
		bombing.direccion = Vector2(0, 100)
		if animated_sprite_2d.flip_h:
			bombing.get_child(1).flip_h = true
		bombing.global_position = origen_bomb_marker_2d.global_position
		get_parent().add_child(bombing)
		oneshot = true
	
func takeDmg(damage):
	health -= damage
	texture_progress_bar_hp.show()
	$TimerHP.start()
	if health <= 0:
		audio_stream_player_dead.play()
		estadoActual = estados.MUERTO
		animated_sprite_2d.modulate = Color(1,1,1,1)
		animated_sprite_2d.play("dead")
		await (animated_sprite_2d.animation_finished)
		queue_free()
		var jugador = get_tree().get_nodes_in_group("player")
		for jgdr in jugador:
			jgdr.sumScore(score)
	else:
		audio_stream_player_hurt.play()
		animated_sprite_2d.modulate = Color(1,0,0.01,1)
		hurt_timer.start()
		await (hurt_timer.timeout)
		animated_sprite_2d.modulate = Color(1,1,1,1)

func _on_damage_player_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(damage)


func _on_change_dir_timer_timeout() -> void:
	direccion *= -1


func _on_bomb_timer_timeout() -> void:
	oneshot = false
	estadoActual = estados.BOMBARDEANDO
	


func _on_timer_hp_timeout() -> void:
	texture_progress_bar_hp.hide()
