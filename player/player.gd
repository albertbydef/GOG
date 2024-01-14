extends CharacterBody2D
class_name player

#Variable de següent nivell
var nextlevel : String

#Variable que controla l'Score necessaari de cada nivell per a cada nota
var scoreA := 0
var scoreB := 0
var scoreC := 0
var scoreD := 0

#Variables de moviment
var speed := 120
var direccion := 0.0
var jump := 220
const gravity = 8

#Variable de vida
var health := 0 :
	set(val):
		health = val
		$HPCanvasLayer/HBoxContainer/HPTextureProgressBar.value = val

#Variables de selecció de fletxa
var tipoflecha : int = 0

#Variables de numero de fletxes especials amb el seu setter
var numflechas_fuego := 0 :
	set(val):
		numflechas_fuego = val
		$FireArrowCanvasLayer/HBoxContainer/FireArrowLabel.text = str(numflechas_fuego)
var numflechas_hielo := 0:
	set(val):
		numflechas_hielo = val
		$IceArrowCanvasLayer2/HBoxContainer/IceArrowLabel.text = str(numflechas_hielo)
var numflechas_electro := 0:
	set(val):
		numflechas_electro = val
		$ElectroArrowCanvasLayer3/HBoxContainer/ElectroArrowLabel.text = str(numflechas_electro)

#Variable de Score
var score := 0:
	set(val):
		score = val
		$ScoreCanvasLayer2/HBoxContainer/ScoreLabel2.text = str(score)
var hplabel := "100/100":
	set(val):
		hplabel = val
		$HPCanvasLayer/HBoxContainer/HPTextureProgressBar/LabelHP.text = hplabel

#Variables de control de dispar
var canShot := true

#Variables de control d'animació
var animation = true

#Estats
enum estados {NORMAL, HERIDO, MUERTO, INVECIBLE}
var estadoActual = estados.NORMAL


#Nodes
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var origen_arma_right_marker_2d: Marker2D = $OrigenArmaRightMarker2D
@onready var origen_arma_left_marker_2d: Marker2D = $OrigenArmaLeftMarker2D
@onready var select_fire_canvas_layer: CanvasLayer = $SelectFireCanvasLayer
@onready var select_ice_canvas_layer: CanvasLayer = $SelectIceCanvasLayer
@onready var select_electro_canvas_layer: CanvasLayer = $SelectElectroCanvasLayer
@onready var shot_timer: Timer = $ShotTimer
@onready var animation_timer: Timer = $AnimationTimer
@onready var invincible_timer: Timer = $InvincibleTimer
#Audio
@onready var audio_stream_player_menu_pause: AudioStreamPlayer = $AudioStreamPlayerMenuPause
@onready var audio_stream_player_change_weapon: AudioStreamPlayer = $AudioStreamPlayerChangeWeapon
@onready var audio_stream_player_shot: AudioStreamPlayer = $AudioStreamPlayerShot
@onready var audio_stream_player_shot_special: AudioStreamPlayer = $AudioStreamPlayerShotSpecial
@onready var audio_stream_player_dead: AudioStreamPlayer = $AudioStreamPlayerDead
@onready var audio_stream_player_jump: AudioStreamPlayer = $AudioStreamPlayerJump
@onready var audio_stream_player_hurt: AudioStreamPlayer = $AudioStreamPlayerHurt
@onready var audio_stream_player_pick_up: AudioStreamPlayer = $AudioStreamPlayerPickUp






#Tipus de fletxes
var flecha_normal = preload("res://Disparos/flecha_normal.tscn")
var flecha_fuego = preload("res://Disparos/flecha_fuego.tscn")
var flecha_hielo = preload("res://Disparos/flecha_hielo.tscn")
var flecha_electro = preload("res://Disparos/flecha_electro.tscn")

func _ready() -> void:
	numflechas_fuego = Global.flechas_fuego
	numflechas_hielo = Global.flechas_hielo
	numflechas_electro = Global.flechas_electro
	score = 0
	$HPCanvasLayer/HBoxContainer/HPTextureProgressBar.max_value = Global.maxHealth
	health = Global.maxHealth
	



#Control de dispar i selecció d'arma
func _input(event: InputEvent) -> void:
	var arrow = flecha_normal.instantiate()
	var fire = flecha_fuego.instantiate()
	var ice = flecha_hielo.instantiate()
	var electro = flecha_electro.instantiate()
	if Input.is_action_just_pressed("ui_cancel"):
		audio_stream_player_menu_pause.play()
		get_tree().paused = true
		$MenuPause.show()
		$MenuPause.get_child(0).get_child(1).grab_focus()
		
	if Input.is_action_just_pressed("change_weapon"):
		audio_stream_player_change_weapon.play()
		select_tipoflecha()
		
	if Input.is_action_just_pressed("ui_accept") and canShot:
		canShot = false
		animation = false
		shot_timer.start()
		animation_timer.wait_time = 0.05
		animation_timer.start()
		match tipoflecha:
			0:
				audio_stream_player_shot.play()
				disparo(arrow)
			1:
				if numflechas_fuego > 0:
					audio_stream_player_shot_special.play()
					disparo(fire)
					restaSpecialArrow("Fuego")
				else:
					audio_stream_player_shot.play()
					disparo(arrow)
			2:
				if numflechas_hielo > 0:
					audio_stream_player_shot_special.play()
					disparo(ice)
					restaSpecialArrow("Hielo")
				else:
					audio_stream_player_shot.play()
					disparo(arrow)
			3:
				if numflechas_electro > 0:
					audio_stream_player_shot_special.play()
					disparo(electro)
					restaSpecialArrow("Electro")
				else:
					audio_stream_player_shot.play()
					disparo(arrow)
			
		

#Funció de control de físiques del player
func _physics_process(delta: float) -> void:
	if estadoActual == estados.NORMAL or estadoActual == estados.INVECIBLE: 
		movimiento(delta)
	if estadoActual == estados.MUERTO:
		if !is_on_floor():
			velocity.y += gravity
			move_and_slide()
			
func _process(delta: float) -> void:
	hplabel = str(health)+"/"+str(Global.maxHealth)

#Moviment del personatge
func movimiento(delta: float) -> void:
	direccion = Input.get_axis("run_left", "run_right")
	velocity.x = direccion * speed
	if direccion != 0 and animation:
			animated_sprite_2d.play("run")  
	elif animation:
		animated_sprite_2d.play("idle")
	animated_sprite_2d.flip_h = direccion < 0 if direccion != 0 else animated_sprite_2d.flip_h
	if is_on_floor() and Input.is_action_just_pressed("jump"):
			audio_stream_player_jump.play()
			velocity.y -= jump
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y < 0 and animation:
			animated_sprite_2d.play("jumpup")
		elif animation:
			animated_sprite_2d.play("jumpfall")
	move_and_slide()


#Dispar del personatge
func disparo(arrow):
	if is_on_floor():
		animated_sprite_2d.play("shot")
	else:
		animated_sprite_2d.play("shotjump")
	if animated_sprite_2d.flip_h:
		arrow.direccion = Vector2(-100, 0)
		arrow.get_child(1).flip_h = true
		arrow.global_position = origen_arma_left_marker_2d.global_position
	else:
		arrow.direccion = Vector2(100, 0)
		arrow.global_position = origen_arma_right_marker_2d.global_position
	get_parent().add_child(arrow)

#Selecció de fletxa del personatge
func select_tipoflecha():
	tipoflecha += 1
	if tipoflecha == 4:
			tipoflecha = 0
	match tipoflecha:
			0:
				select_electro_canvas_layer.hide()
			1:
				select_fire_canvas_layer.show()
			2:
				select_ice_canvas_layer.show()
				select_fire_canvas_layer.hide()
			3:
				select_electro_canvas_layer.show()
				select_ice_canvas_layer.hide()

			
#Funció suma fletxes especials dels coleccionables
func takeSpecialArrow(arrow):
	audio_stream_player_pick_up.play()
	if arrow == "Fuego":
		numflechas_fuego += 1
	elif arrow == "Hielo":
		numflechas_hielo += 1
	elif arrow == "Electro":
		numflechas_electro += 1

#Funció que resta fletxes especials
func restaSpecialArrow(arrow):
	if arrow == "Fuego":
		numflechas_fuego -= 1
	elif arrow == "Hielo":
		numflechas_hielo -= 1
	elif arrow == "Electro":
		numflechas_electro -= 1
#Funció suma puntuació score
func sumScore(scr):
	score += scr

#Temporitzador per tornar a disparar
func _on_shot_timer_timeout() -> void:
	canShot = true

#Temporitzador d'animació
func _on_animation_timer_timeout() -> void:
	animation = true
	if estadoActual == estados.INVECIBLE:
		animated_sprite_2d.modulate = Color(1,1,1,0.5)
	else:
		estadoActual = estados.NORMAL
		animated_sprite_2d.modulate = Color(1,1,1,1)
	
#Funció suma vida al player
func sumHealth(vida):
	audio_stream_player_pick_up.play()
	health += vida
	if health > Global.maxHealth:
		health = Global.maxHealth
	
#Funció de control de mal del personatge
func takeDmg(damage):
	health -= damage
	if health <= 0:
		audio_stream_player_dead.play()
		animation = false
		animation_timer.wait_time = 3
		animation_timer.start()
		estadoActual = estados.MUERTO
		animated_sprite_2d.play("dead")
		await (animated_sprite_2d.animation_finished)
		get_tree().paused = true
		$GameOverScreen.show()
		$GameOverScreen.get_child(0).get_child(1).grab_focus()
	else:
		audio_stream_player_hurt.play()
		animation = false
		animation_timer.start(0.5)
		estadoActual = estados.HERIDO
		animated_sprite_2d.modulate = Color(1,0,0.01,0.5)
		animated_sprite_2d.play("hurt")
		estadoActual = estados.INVECIBLE
		collision_layer = 32
		collision_mask = 4
		invincible_timer.start()
		
func finishedLevel(actuallevel, level, scrA, scrB):
	get_tree().paused = true
	$FinalLevel.nextlevel = level
	$FinalLevel.show()
	$FinalLevel.get_child(0).get_child(4).grab_focus()
	scoreA = scrA
	scoreB = scrB
	$FinalLevel.scorelvl(score, scoreA, scoreB)
	awards(actuallevel)
	$FinalLevel.flechas_hielo = numflechas_hielo
	$FinalLevel.flechas_fuego = numflechas_fuego
	$FinalLevel.flechas_electro = numflechas_electro
	

func _on_invincible_timer_timeout() -> void:
	estadoActual = estados.NORMAL
	animated_sprite_2d.modulate = Color(1,1,1,1)
	collision_layer = 1
	collision_mask = 14

func awards(actuallev):
	match actuallev:
		1:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl1hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl1hp = true
				numflechas_hielo += 5
				$FinalLevel.awards(hpmax,0,5,0)
			if score < scoreA and score >= scoreB:
				numflechas_hielo += 2
				$FinalLevel.awards(0,0,2,0)
		2:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl2hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl2hp = true
				numflechas_hielo += 5
				$FinalLevel.awards(hpmax,0,5,0)
			if score < scoreA and score >= scoreB:
				numflechas_hielo += 2
				$FinalLevel.awards(0,0,2,0)
		3:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl3hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl3hp = true
				numflechas_hielo += 5
				$FinalLevel.awards(hpmax,0,5,0)
			if score < scoreA and score >= scoreB:
				numflechas_hielo += 2
				$FinalLevel.awards(0,0,2,0)
		4:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl4hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl4hp = true
				numflechas_fuego += 5
				$FinalLevel.awards(hpmax,5,0,0)
			if score < scoreA and score >= scoreB:
				numflechas_fuego += 2
				$FinalLevel.awards(0,2,0,0)
		5:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl5hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl5hp = true
				numflechas_fuego += 5
				$FinalLevel.awards(hpmax,5,0,0)
			if score < scoreA and score >= scoreB:
				numflechas_fuego += 2
				$FinalLevel.awards(0,2,0,0)
		6:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl6hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl6hp = true
				numflechas_fuego += 5
				$FinalLevel.awards(hpmax,5,0,0)
			if score < scoreA and score >= scoreB:
				numflechas_fuego += 2
				$FinalLevel.awards(0,2,0,0)
		7:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl7hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl7hp = true
				numflechas_electro += 5
				$FinalLevel.awards(hpmax,0,0,5)
			if score < scoreA and score >= scoreB:
				numflechas_electro += 2
				$FinalLevel.awards(0,0,0,2)
		8:
			if score >= scoreA:
				var hpmax = 0
				if !Global.lvl8hp:
					Global.maxHealth += 10
					hpmax = 10
					Global.lvl8hp = true
				numflechas_electro += 5
				$FinalLevel.awards(hpmax,0,0,5)
			if score < scoreA and score >= scoreB:
				numflechas_electro += 2
				$FinalLevel.awards(0,0,0,2)
