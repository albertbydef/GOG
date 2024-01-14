extends CharacterBody2D

var direccion := -1
var direccionshot := -1
var speed := 30
var canChangeDireccion := true
var player
enum estados {DAÑO1, DAÑO2, DAÑO3, MUERTO}
var estadoActual = estados.DAÑO1
var colision
var oneshot := false
var animationplay := false

var health := 500
var damage := 10
var score := 5000

@onready var ray_cast_suelo: RayCast2D = $Raycast/RayCastSuelo
@onready var ray_cast_pared: RayCast2D = $Raycast/RayCastPared
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: Node2D = $Raycast
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_timer: Timer = $Raycast/RayTimer
@onready var hurt_timer: Timer = $HurtTimer
@onready var origen_slash_right_marker_2d: Marker2D = $OrigenSlashRightMarker2D
@onready var origen_slash_left_marker_2d: Marker2D = $OrigenSlashLeftMarker2D
@onready var shot_timer: Timer = $ShotTimer



var ice_slash = preload("res://Enemies/ice/ice_slash.tscn")


func _ready() -> void:
	animated_sprite_2d.play("walk")

func _physics_process(delta: float) -> void:
	velocity.x = direccion * speed
	move_and_slide()

func _process(delta: float) -> void:	
	if canChangeDireccion and ray_cast_pared.is_colliding():
		changeDirection()
		
	animated_sprite_2d.flip_h = true if direccion == 1 else false
	collision_shape_2d.scale.x = -0.1 if direccion == 1 else 0.1

func changeDirection():
	canChangeDireccion = false
	ray_timer.start()
	direccion *= -1
	direccionshot *= -1
	raycast.scale.x *= -1

func takeDmg(damage):
	health -= damage
	var jugador = get_tree().get_nodes_in_group("player")
	if health <= 0:
		estadoActual = estados.MUERTO
		animated_sprite_2d.modulate = Color(1,1,1,1)
		animated_sprite_2d.play("dead")
		await (animated_sprite_2d.animation_finished)
		for jgdr in jugador:
			jgdr.sumScore(score)
		queue_free()
	else:
		animated_sprite_2d.modulate = Color(1,0,0.01,1)
		hurt_timer.start()
		await (hurt_timer.timeout)
		animated_sprite_2d.modulate = Color(1,1,1,1)

func slashAttack():
	var ice = ice_slash.instantiate()
	if !animationplay:
		animated_sprite_2d.play("attack")
		animationplay = true
		direccion = 0
	await(animated_sprite_2d.animation_finished)
	animationplay = false
	if animated_sprite_2d.flip_h:
		ice.direccion = Vector2(100, 0)
		ice.get_child(1).flip_h = true
		ice.global_position = origen_slash_right_marker_2d.global_position
	else:
		ice.direccion = Vector2(-100, 0)
		ice.global_position = origen_slash_left_marker_2d.global_position
	if !oneshot:
		get_parent().add_child(ice)
		oneshot = true
		shot_timer.start(1)

func _on_ray_timer_timeout() -> void:
	canChangeDireccion = true


func _on_damage_player_body_entered(body: Node2D) -> void:
	if body is player:
		body.takeDmg(damage)


func _on_shot_timer_timeout() -> void:
	oneshot = false
