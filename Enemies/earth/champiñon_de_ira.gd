extends CharacterBody2D

var direccion := -1
var directionflag := false
var speed := 10
var canChangeDireccion := true
var player
var directionPlayer
enum estados {PATRULLAR, ANGRY, MUERTO, CARGANDO}
var estadoActual = estados.PATRULLAR
var colision
var timer := false

var health := 60:
	set(val):
		health = val
		$TextureProgressBarHP.value = val
var damage := 25
var score := 500
@onready var ray_cast_suelo: RayCast2D = $Raycast/RayCastSuelo
@onready var ray_cast_pared: RayCast2D = $Raycast/RayCastPared
@onready var ray_cast_suelo_2: RayCast2D = $Raycast/RayCastSuelo2
@onready var ray_cast_suelo_3: RayCast2D = $Raycast/RayCastSuelo3
@onready var ray_cast_pared_2: RayCast2D = $Raycast/RayCastPared2
@onready var ray_cast_pared_3: RayCast2D = $Raycast/RayCastPared3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: Node2D = $Raycast
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_timer: Timer = $Raycast/RayTimer
@onready var ray_cast_detector_player: RayCast2D = $RayCastDetectorPlayer
@onready var hurt_timer: Timer = $HurtTimer
@onready var ray_cast_attack: RayCast2D = $RayCastAttack
@onready var charge_attack_timer: Timer = $ChargeAttackTimer
#Audio
@onready var audio_stream_player_dead: AudioStreamPlayer = $AudioStreamPlayerDead
@onready var audio_stream_player_attack: AudioStreamPlayer = $AudioStreamPlayerAttack
@onready var audio_stream_player_hurt: AudioStreamPlayer = $AudioStreamPlayerHurt
@onready var audio_stream_player_detect: AudioStreamPlayer = $AudioStreamPlayerDetect

@onready var texture_progress_bar_hp: TextureProgressBar = $TextureProgressBarHP




func _ready() -> void:
	animated_sprite_2d.play("walk")
	texture_progress_bar_hp.max_value = health

func _physics_process(delta: float) -> void:
	if estadoActual == estados.CARGANDO:
		speed = 0
		velocity.x = direccion * speed
		if !is_on_floor():
			velocity.y += 9
	else:
		velocity.x = direccion * speed
		if !is_on_floor():
			velocity.y += 9
	move_and_slide()

func _process(delta: float) -> void:
	colision = ray_cast_detector_player.get_collider()
	if player == null and ray_cast_detector_player.is_colliding():
		if colision.is_in_group("player"):
			audio_stream_player_detect.play()
			player = colision
			if !directionflag:
				directionflag = true
				directionPlayer = global_position.direction_to(player.global_position)
				print(directionPlayer)
			if directionPlayer.x < 0:
				direccion = -1
			elif directionPlayer.x > 0:
				direccion = 1
			estadoActual = estados.CARGANDO
			
	
	if estadoActual == estados.CARGANDO and player != null:
		speed = 100
		animated_sprite_2d.speed_scale = 2
		damage = 35
		animated_sprite_2d.play("attack")
		if !timer:
			timer = true
			charge_attack_timer.start(3)
		await (charge_attack_timer.timeout)
		audio_stream_player_attack.play()
		timer = false
		directionflag = false
		estadoActual = estados.ANGRY
		
	if estadoActual == estados.ANGRY and $Raycast/RayCastPared.is_colliding():
		estadoActual = estados.PATRULLAR
		
	if player != null and !ray_cast_detector_player.is_colliding() and estadoActual != estados.ANGRY:
		speed = 15
		animated_sprite_2d.play("walk")
		animated_sprite_2d.speed_scale = 1
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
	collision_shape_2d.scale.x = -0.1 if direccion == 1 else 0.1

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
		audio_stream_player_hurt
		animated_sprite_2d.modulate = Color(1,0,0.01,1)
		hurt_timer.start()
		await (hurt_timer.timeout)
		animated_sprite_2d.modulate = Color(1,1,1,1)

func _on_ray_timer_timeout() -> void:
	canChangeDireccion = true


func _on_damage_player_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(damage)
		estadoActual = estados.PATRULLAR



func _on_timer_hp_timeout() -> void:
	texture_progress_bar_hp.hide()
