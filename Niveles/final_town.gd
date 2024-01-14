extends Node
#var contDialog := 0
var dialog = [
	'Nil: ¡Está todo en llamas!',
	'Druida: ¡¿Que está pasando?!',
	'???: ¡Habéis osado robar las tres joyas de mi mundo!',
	'Nil: Esa voz... viene del cielo.',
	'???: Devolvedlas o acabare con todos vosotros.',
	'Druida: ¡Hemos despertado a un dios!',
	'Nil: ¡¿Que dios?!',
	'Druida: El dios supremo de Gaia, "La nave" lo identifico como "La Niebla".',
	'Nil: Voy a hablar con el, sino lo va a destruir todo...',
	'Druida: ¡No! ¡Corres peligro!',
	'Nil: No Hay otra salida.',
	'Nil: [Grito]- ¡Aquí estoy, yo soy el que tiene tus tres joyas! - [Grito]',
	'La Niebla: Tu, pequeño, ¿porque has robado las tres joyas?',
	'Nil: Una enfermedad de este mundo está acabando con todos nosotros y los necesito para salvar a mi madre.',
	'La Niebla: ¡Vosotros invadisteis el mundo que creé!',
	'Nil: Nosotros solo queremos vivir en paz en este mundo.',
	'La Niebla: De acuerdo, así se hará, habéis demostrado ser una especie digna de este mundo consiguiendo mis tres joyas',
	'La Niebla: El mal que os afectaba ya no os afectara, este mundo os acepta como legitima raza',
	'La Niebla: A cambio voy a devolver mis tres joyas a su lugar.',
	'Nil: Aquí las tienes.',
	'La Niebla: Ya está hecho, vivid con armonía en mi mundo.',
	'Nil: Gracias',
	'Druida: Ve a ver a tu madre, ya habrá despertado.',
	'Nil: Gracias Druida por todo, voy a ver a mi madre.'
	#'La Niebla: Que mi guardian dicte sentencia!'
	]
#var dialog2 = [
#	'Nil: Voy a luchar con el.',
#	'Druida: Ten cuidado.',
#	'Nil: Descuida, lo tendré.'
#]
var completed := false
var play = false

@onready var control_dialog: Control = $ControlDialog
@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2


func _ready() -> void:
	completed = true
	

func _process(delta: float) -> void:
	if control_dialog.dialog_index == 12 and !play:
		play = true
		audio_stream_player.stop()
		audio_stream_player_2.play()
	if completed:
		completed = false
		canvas_layer_transition.get_child(1).play_backwards("transition")
		await(canvas_layer_transition.get_child(1).animation_finished)
		control_dialog.dialog = dialog
		control_dialog.load_dialog()


func _on_control_dialog_clear() -> void:
	#if contDialog == 0:
	#	animation_player.play("elemental")
	#	await (animation_player.animation_finished)
	#	control_dialog.dialog = dialog2
	#	control_dialog.load_dialog()
	#	contDialog += 1
	#else:
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	completed = true
	get_tree().change_scene_to_file("res://Niveles/final_mother.tscn")
