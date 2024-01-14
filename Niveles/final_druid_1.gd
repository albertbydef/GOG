extends Node
var contDialog := 0
var dialog = [
	'Druida: : ¡Benditos mis ojos! ¡No puedo creer lo que veo!',
	'Druida: ¡Has vuelto!',
	'Nil: Hola Druida.',
	'Druida: Veo que te has hecho más fuerte y por tus ojos puedo ver que lo has conseguido.',
	'Nil: Ha sido un camino duro, pero aquí te traigo los tres frutos mágicos para crear la poción',
	'Druida: He intentado cuidar de tu madre el tiempo que no estabas.',
	'Druida: Me preguntaba por ti... Donde estabas... Y yo le respondía que cazando que no se preocupara que en unos días volverías.',
	'Druida: Aunque ahora mismo su estado ha empeorado, está en sueño profundo en su cama y no puede despertarse, es el último síntoma de la enfermedad antes de morir.',
	'Druida: Le queda poco tiempo.',
	'Nil: ¡Por favor! Date prisa y crea esa poción.',
	'Druida: Lo siento hijo, debo darte una mala noticia.',
	'Druida: Volví a las ruinas a revisar el ordenador central... y no existe poción...',
	'Druida: El escaneo y análisis de "La Nave" fue correcto, la clave se encontraba en estos tres frutos mágicos.',
	'Druida: Pero... descubrí que el archivo donde se detallaba la poción fue añadido por un operador como posible teoría de lo que se debía hacer con los tres frutos, aunque, es infundada.',
	'Druida: Así que la poción nunca ha existido, y no sabemos cómo utilizar los tres frutos para salvar a tu madre y a la humanidad...',
	'Druida: Lo siento hijo...',
	'Nil: No podemos quedarnos de manos cruzadas, intenta crear esa poción, posiblemente funcione, te lo suplico.',
	'Druida: Lo siento... Los tres frutos mágicos son los únicos del planeta, si nos equivocamos estamos destinados a la extinción, no podemos arriesgarnos a perderlo todo...',
	'Nil: Pero yo perderé a mi madre sino...',
	'Druida: Nil... Incluso esa posible poción podría matar a tu madre antes de lo esperado, no debemos arriesgarnos y estudiarlo más detenidamente.',
	'Nil: ¡¡AAARRRGGGHHH!! No puedo quedarme sin hacer nada... plof plof',
	'Druida: Lo siento, ahora mismo no hay nada que hacer...' 
	]
var dialog2 = [
	'???: Donde está el que osa perturbar mi mundo?',
	'Nil: Esta temblando todo. ¡¿Quién es el que habla?!',
	'Druida: No lo sé, la voz viene de todas partes...',
	'Druida: ¡Salgamos antes de que esto se derrumbe!'
]
var completed := false

@onready var control_dialog: Control = $ControlDialog
@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2


func _ready() -> void:
	completed = true
	

func _process(delta: float) -> void:
	if completed:
		completed = false
		canvas_layer_transition.get_child(1).play_backwards("transition")
		await(canvas_layer_transition.get_child(1).animation_finished)
		control_dialog.dialog = dialog
		control_dialog.load_dialog()


func _on_control_dialog_clear() -> void:
	if contDialog == 0:
		animation_player.play("earthquake")
		audio_stream_player.stop()
		audio_stream_player_2.play()
		timer.start()
		await (timer.timeout)
		control_dialog.completedialog = false
		control_dialog.dialog = dialog2
		control_dialog.load_dialog()
		contDialog += 1
	else:
		canvas_layer_transition.get_child(1).play("transition")
		await(canvas_layer_transition.get_child(1).animation_finished)
		completed = true
		get_tree().change_scene_to_file("res://Niveles/final_town.tscn")
	
