extends CharacterBody2D

var direccion := -1
var speed := 20
var canChangeDireccion := true
var player
enum estados {PATRULLAR, ANGRY, MUERTO}
var estadoActual = estados.PATRULLAR
var colision

var health := 30:
	set(val):
		health = val
		$TextureProgressBarHP.value = val
var damage := 20
var score := 400

@onready var ray_cast_suelo: RayCast2D = $Raycast/RayCastSuelo
@onready var ray_cast_pared: RayCast2D = $Raycast/RayCastPared
@onready var ray_cast_suelo_2: RayCast2D = $Raycast/RayCastSuelo2
@onready var ray_cast_suelo_3: RayCast2D = $Raycast/RayCastSuelo3
@onready var ray_cast_pared_2: RayCast2D = $Raycast/RayCastPared2
@onready var ray_cast_pared_3: RayCast2D = $Raycast/RayCastPared3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: Node2D = $Raycast
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var ray_timer: Timer = $Raycast/rayTimer
@onready var ray_cast_detector_player: RayCast2D = $RayCastDetectorPlayer
@onready var ray_cast_attack: RayCast2D = $RayCastAttack
@onready var hurt_timer: Timer = $HurtTimer
@onready var damage_player: Area2D = $damagePlayer
@onready var audio_stream_player_attack: AudioStreamPlayer = $AudioStreamPlayerAttack
@onready var audio_stream_player_dead: AudioStreamPlayer = $AudioStreamPlayerDead
@onready var audio_stream_player_hurt: AudioStreamPlayer = $AudioStreamPlayerHurt
@onready var texture_progress_bar_hp: TextureProgressBar = $TextureProgressBarHP



func _ready() -> void:
	animated_sprite_2d.play("walk")
	health = 30
	texture_progress_bar_hp.max_value = 30
	speed = 20

func _physics_process(delta: float) -> void:
	velocity.x = direccion * speed
	
	if !is_on_floor():
		velocity.y += 9
	move_and_slide()

func _process(delta: float) -> void:
	colision = ray_cast_detector_player.get_collider()
	if player == null and ray_cast_detector_player.is_colliding():
		if colision.is_in_group("player"):
			audio_stream_player_attack.play()
			player = colision
			estadoActual = estados.ANGRY
	
	if estadoActual == estados.ANGRY and player != null:
		speed = 40
		animated_sprite_2d.speed_scale = 2
		if ray_cast_attack.is_colliding():
			damage = 20
			animated_sprite_2d.play("attack")
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direccion = -1
		elif directionPlayer.x > 0:
			direccion = 1
			
	if player != null and !ray_cast_detector_player.is_colliding():
		speed = 20
		animated_sprite_2d.play("walk")
		player = null
		estadoActual = estados.PATRULLAR
		damage = 10
		
	if estadoActual == estados.PATRULLAR:
		if canChangeDireccion and (ray_cast_pared.is_colliding() or ray_cast_pared_2.is_colliding() or ray_cast_pared_3.is_colliding() or !ray_cast_suelo.is_colliding() or !ray_cast_suelo_2.is_colliding() or !ray_cast_suelo_3.is_colliding()):
			canChangeDireccion = false
			ray_timer.start()
			direccion *= -1
			raycast.scale.x *= -1
			ray_cast_detector_player.scale.x *= -1
			ray_cast_attack.scale.x *= -1
		
	animated_sprite_2d.flip_h = true if direccion == 1 else false
	collision_polygon_2d.scale.x = -0.1 if direccion == 1 else 0.1
	damage_player.scale.x = -1 if direccion == 1 else 1

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

func _on_ray_timer_timeout() -> void:
	canChangeDireccion = true


func _on_damage_player_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(damage)


func _on_timer_hp_timeout() -> void:
	texture_progress_bar_hp.hide()
