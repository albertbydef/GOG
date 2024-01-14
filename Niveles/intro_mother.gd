extends Node
var dialog = [
	'Nil: Madre, voy a cazar a las afueras del pueblo para tener suministros.',
	'Nera: Perfecto, ten cuidado y muchas gracias, hijo, ojalá tu padre pudiera verte, te enseño bien el arte de la caza.',
	'Nera:  ¡Y como has crecido! A tus 17 años ya estas hecho todo un hombre, te pareces mucho a el.',
	'Nil: Gracias Madre, ojalá Papa siguiera vivo, espero que este orgulloso de mi este donde este.',
	'Nera: Cof Cof Cof',
	'Nil: ¡Mama! ¿Estas bien?',
	'Nera: No te preocupes hijo, es un poco de tos, hoy he ido a ver al doctor del pueblo y me ha dicho que puedo padecer la enfermedad de Gaia, pero yo estoy segura de que es un simple resfriado',
	'Nil: No quiero perderte madre, la enfermedad de Gaia es la misma que se llevó a Papa...',
	'Nera: Cof Cof Cof',
	'Nera: Hijo mío, ve a cazar tranquilo, no me pasara nada.',
	'Nil: Pero Madre, no quiero que te pase nada.',
	'Nera: Lo se hijo, y no pienses en eso, de todas formas, si fuera la enfermedad de Gaia no hay remedio... es una muerte segura, pero sería feliz de ir al cielo con tu padre y de haber visto el hombre en que te has convertido.',
	'Nil: No madre, no digas eso...',
	'Nera: Hijo, por favor, no pienses en eso y ve a cazar.',
	'Nil: Vale madre, pero yo te pido que mientras no este te cuides y no hagas esfuerzos.',
	'Nera: Así lo haré hijo mío, antes de salir del pueblo pasa a visitar al druida, aunque está un poco loco el fue muy amigo de tu padre y estuvo cerca de él hasta sus últimos días',
	'Nil: Vale mama, te quiero, nos vemos pronto.',
	'Nera: Yo también te quiero... Cof Cof Cof... adiós, hijo mío.'
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
	get_tree().change_scene_to_file("res://Niveles/intro_druid.tscn")
