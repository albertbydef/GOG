extends Node
var dialog = [
	'Nil: ¡Hola Druida!',
	'Druida: ¡Hola Campeón! ¡Me alegro de verte, que grande estas! Jajaja.',
	'Nil: ¡Gracias Druida! He venido a ver como estabas, aunque estoy preocupado.',
	'Druida: ¿Que ha pasado? ¿Que te preocupa campeón?',
	'Nil: Es mi madre... Ha empezado a toser y el doctor le ha dicho que puede ser la enfermedad de Gaia...',
	'Nil: Druida, siento contarte esto, no quiero perder a mi madre como perdí a mi padre, tu conocías a mi padre lo debes entender.',
	'Druida: Siento mucho lo que me estás diciendo, no quiero que le pase esto a tu madre porque al igual que tu padre me une una gran amistad con ella.',
	'Druida: Nos encontramos ante una situación urgente, la tos es el primer síntoma de la enfermedad y, desde que aparece, los síntomas van empeorando hasta que al cabo de pocas semanas la persona muere.',
	'Nil: ¡Oh no! No puede ser, me niego a perderla...',
	'Druida: : Puede haber una solución, pero es una locura hasta para mi, que me consideran el loco del pueblo, y creo que no debería decírtelo.',
	'Nil: Por favor, estoy dispuesto a hacer cualquier cosa.',
	'Druida: : Tu padre y yo hicimos un descubrimiento, cuando el contrajo la enfermedad, decidimos no quedarnos de manos cruzadas mientras siguiera con vida y empezamos a buscar donde nadie había buscado antes.',
	'Druida: Tu padre y yo éramos exploradores aparte de cazadores y un día decidimos entrar en las ruinas prohibidas donde se había estrellado antiguamente "La Nave", el origen de nuestro pueblo en este mundo.',
	'Druida: En lo más profundo de las ruinas bajo una capa espesa de vegetación descubrimos el ordenador central de "La Nave".',
	'Druida: Gracias a que tu padre y yo cuando éramos jóvenes habíamos estado indagando en la tecnología antigua conseguimos hackear y acceder al archivo del ordenador central',
	'Druida:: En él se nos descubrieron ante nuestros ojos muchos misterios escondidos hasta entonces.',
	'Druida: "La Nave" antes de estrellarse hizo un escaneo y análisis del planeta, y descubrió el misterio que nos azota',
	'Druida: Este mundo fue creado con una protección a amenazas externas a el, solo deja vivir en el a criaturas originarias él...',
	'Druida: La enfermedad de Gaia, así como la llamamos nosotros es realmente el antivirus de este mundo, actúa como tal, eliminando las especies externas que considera una amenaza',
	'Druida: Pero el ordenador encontró como desactivar ese antivirus... Hay tres zonas conocidas de este mundo que las llamamos Bosque Salvaje, Montañas Heladas y Desierto Infernal',
	'Druida: Al final de cada zona hay un fruto mágico que si se juntan los tres en una poción y una persona bebe solo un sorbo de ella la enfermedad no le atacara a él ni a sus descendientes',
	'Druida: Es decir, creara una excepción en el antivirus, para él y sus próximas generaciones.',
	'Druida: Los primeros hombres intentaron llegar a ellos, pero ninguna expedición llego al objetivo, todos murieron en el intento o desaparecieron, las criaturas de este mundo son muy peligrosas.',
	'Druida: Con el paso del tiempo se fueron abandonando las expediciones, pero la enfermedad de cada vez aparecía antes hasta que hoy en día la esperanza de vida es de solo 40 años.',
	'Druida: Tu padre lo sabía y aceptó su destino, es un suicidio y enviar a una muerte casi asegurada a cualquiera, discúlpame no te he contado nada de esto olvídalo, lo mejor es aceptar nuestro destino.',
	'Nil: No, me niego a aceptarlo, voy a conseguir esos frutos y a salvar a mi madre.',
	'Druida: Por favor, no vayas, no me lo perdonaría si te pasara algo.',
	'Nil: Debo ir, es mi deber.',
	'Druida: Lo siento... Pero creo que no podre pararte, si es así, cuando consigas los frutos tráemelos y yo creare la poción mágica para tu madre.',
	'Druida: Por favor, ve con cuidado, se que tu padre te enseño bien, recuerda sus enseñanzas.',
	'Nil: Lo hare. Gracias, nos vemos pronto.',
	'Druida: Un último consejo antes de irte. Utiliza bien tus recursos y no los malgastes. ¡Hasta pronto!',
	'Nil: Gracias.',
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
	get_tree().change_scene_to_file("res://Niveles/intro_final.tscn")
