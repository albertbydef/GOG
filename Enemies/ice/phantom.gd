extends CharacterBody2D

var direccion := -1
var speed := 10
var canChangeDireccion := true
var player
enum estados {PATRULLAR, ANGRY, MUERTO}
var estadoActual = estados.PATRULLAR
var colision
var pos := Vector2(0,0)

var is_vanishing := false

var health := 70:
	set(val):
		health = val
		$TextureProgressBarHP.value = val
var damage := 25
var score := 800

@onready var ray_cast_suelo: RayCast2D = $Raycast/RayCastSuelo
@onready var ray_cast_suelo_2: RayCast2D = $Raycast/RayCastSuelo2
@onready var ray_cast_suelo_3: RayCast2D = $Raycast/RayCastSuelo3
@onready var ray_cast_pared: RayCast2D = $Raycast/RayCastPared
@onready var ray_cast_pared_2: RayCast2D = $Raycast/RayCastPared2
@onready var ray_cast_pared_3: RayCast2D = $Raycast/RayCastPared3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: Node2D = $Raycast
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_timer: Timer = $Raycast/RayTimer
@onready var ray_cast_detector_player: RayCast2D = $RayCastDetectorPlayer
@onready var hurt_timer: Timer = $HurtTimer
@onready var ray_cast_attack: RayCast2D = $RayCastAttack
@onready var collision_shape_2d_damage: CollisionShape2D = $DamagePlayer/CollisionShape2DDamage
@onready var vanish_animation_player: AnimationPlayer = $VanishAnimationPlayer
@onready var audio_stream_player_dead: AudioStreamPlayer = $AudioStreamPlayerDead
@onready var audio_stream_player_attack: AudioStreamPlayer = $AudioStreamPlayerAttack
@onready var audio_stream_player_vanish: AudioStreamPlayer = $AudioStreamPlayerVanish
@onready var audio_stream_player_hurt: AudioStreamPlayer = $AudioStreamPlayerHurt

@onready var texture_progress_bar_hp: TextureProgressBar = $TextureProgressBarHP



func _ready() -> void:
	animated_sprite_2d.play("walk")
	texture_progress_bar_hp.max_value = health

func _physics_process(delta: float) -> void:
	if !is_vanishing:
		velocity.x = direccion * speed
		if !is_on_floor():
			velocity.y += 9
		move_and_slide()
	if is_vanishing:
		audio_stream_player_vanish.play()
		if direccion == -1 and is_vanishing:
			is_vanishing = false
			vanish_animation_player.play("vanishing")
			await (vanish_animation_player.animation_finished)
			global_position.x = pos.x - 18
			global_position.y = pos.y
			changeDirection()
			vanish_animation_player.play_backwards("vanishing")
			
			
		if direccion == 1 and is_vanishing:
			is_vanishing = false
			vanish_animation_player.play("vanishing")
			await (vanish_animation_player.animation_finished)
			global_position.x = pos.x + 25
			global_position.y = pos.y
			changeDirection()
			vanish_animation_player.play_backwards("vanishing")
			

func _process(delta: float) -> void:
	colision = ray_cast_detector_player.get_collider()
	if player == null and ray_cast_detector_player.is_colliding():
		pos = colision.global_position
		audio_stream_player_attack.play()
		if colision.is_in_group("player"):
			player = colision
			estadoActual = estados.ANGRY
			is_vanishing = true
	
	if estadoActual == estados.ANGRY and player != null and !is_vanishing:
		speed = 30
		animated_sprite_2d.speed_scale = 2
		if ray_cast_attack.is_colliding():
			damage = 35
			animated_sprite_2d.play("attack")
		var directionPlayer = global_position.direction_to(player.global_position)
		if directionPlayer.x < 0:
			direccion = -1
		elif directionPlayer.x > 0:
			direccion = 1
			
	if player != null and !ray_cast_detector_player.is_colliding() and !is_vanishing:
		speed = 15
		animated_sprite_2d.play("walk")
		animated_sprite_2d.speed_scale = 1
		player = null
		estadoActual = estados.PATRULLAR
		damage = 10
		
	if estadoActual == estados.PATRULLAR:
		if canChangeDireccion and (ray_cast_pared.is_colliding() or ray_cast_pared_2.is_colliding() or ray_cast_pared_3.is_colliding() or !ray_cast_suelo.is_colliding() or !ray_cast_suelo_2.is_colliding() or !ray_cast_suelo_3.is_colliding()):
			changeDirection()
			canChangeDireccion = false
			ray_timer.start()
		
	animated_sprite_2d.flip_h = true if direccion == 1 else false
	collision_shape_2d.position.x = -11 if direccion == 1 else 0
	collision_shape_2d_damage.position.x = -9 if direccion == 1 else -3
	raycast.position.x = -11 if direccion == 1 else 0
	ray_cast_detector_player.position.x = -11 if direccion == 1 else 0
	ray_cast_attack.position.x = -11 if direccion == 1 else 0
	

func changeDirection():
	direccion *= -1
	raycast.scale.x *= -1
	ray_cast_detector_player.scale.x *= -1
	ray_cast_attack.scale.x *= -1

func takeDmg(damage):
	health -= damage
	texture_progress_bar_hp.show()
	$TimerHP.start()
	var jugador = get_tree().get_nodes_in_group("player")
	if health <= 0:
		audio_stream_player_dead.play()
		estadoActual = estados.MUERTO
		animated_sprite_2d.modulate = Color(1,1,1,1)
		animated_sprite_2d.play("dead")
		await (animated_sprite_2d.animation_finished)
		for jgdr in jugador:
			jgdr.sumScore(score)
		queue_free()
	else:
		audio_stream_player_hurt.play()
		animated_sprite_2d.modulate = Color(1,0,0.01,1)
		hurt_timer.start()
		for jgdr in jugador:
			if global_position.x < jgdr.global_position.x and direccion < 0:
				changeDirection()
			if global_position.x > jgdr.global_position.x and direccion > 0:
				changeDirection()
		await (hurt_timer.timeout)
		animated_sprite_2d.modulate = Color(1,1,1,1)

func _on_ray_timer_timeout() -> void:
	canChangeDireccion = true


func _on_damage_player_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(damage)


func _on_timer_hp_timeout() -> void:
	texture_progress_bar_hp.hide()
