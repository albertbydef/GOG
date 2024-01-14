extends Node
var dialog = [
	'Nil: ¡Hola madre, ya estas bien!',
	'Nera: Si, he tenido una pesadilla terrible y de repente he visto una luz y he despertado, he notado como todo el peso que sentía mi cuerpo desaparecía.',
	'Nil: Gracias, te quiero madre, me pensaba te iba a perder.',
	'Nera: ¿Por qué?',
	'Nil: Estabas dormida, la enfermedad de Gaia te afectaba, pero el Dios de este mundo nos ha perdonado a todos, la enfermedad ha desaparecido.',
	'Nera: ¿Ha sido cosa tuya?',
	'Nil: Lo he intentado.',
	'Nera: Gracias hijo mío, tu padre estaría orgulloso de ti, ojalá te vea aquí donde este.',
	'Nil: Gracias madre.',
	'Nera: ¡Vamos a cenar, te preparare tu plato favorito!',
	'Nil: Muchas gracias.'
	]
var completed := false

@onready var control_dialog: Control = $ControlDialog
@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition

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
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	completed = true
	get_tree().change_scene_to_file("res://Niveles/final.tscn")
