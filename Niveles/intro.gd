extends Node
var contDialog := 0
var dialogLaNiebla = [
	'Hace mucho tiempo, cuando el propio tiempo era joven, apareció en el vacío del espacio "La niebla".',
	'"La niebla" era un ente poderoso, rebosante de vida y tan grande que era capaz de tragarse planetas enteros.',
	'Con el paso del tiempo, del interior de "La niebla", gracias a su inmenso poder, surgió una superficie, una tierra que fue despertando, como un bebe cuando sale de las entrañas de su madre.', 
	'En esta nueva tierra se formaron montañas abismales, volcanes monstruosos, desiertos mortíferos, vegetación tan densa como el acero, arboles tan altos que rascaban las nubes, y por último, surgieron las criaturas salvajes y únicos habitantes de este mundo.',
	'Era un mundo salvaje e indómito, que creció sin ninguna regla y era donde la propia naturaleza ganaba su nombre.'
	]
var dialogLaNave = [
	'Este mundo situado en los albores del universo se mantuvo escondido de cualquier amenaza exterior, hasta que apareció "La Nave"...',
	'La Nave" era un artefacto espacial creado por la raza humana con el fin de explorar y colonizar mundos, en ella viajaban 200 humanos en cámaras de criogenización que los mantenía vivos y en estado de letargo eterno.',
	'La raza humana, era una raza ambiciosa, que desde su origen evoluciono tecnológicamente a pasos agigantados aprovechando cualquier recurso que le daba su mundo.',
	'Esta evolución tecnológica los convirtió en el propio virus que llevaría a la muerte cualquier forma de vida en su propio mundo.',
	'Cuando quisieron dar marcha atrás ya era tarde, su mundo se volvió contra ellos, en pocos años "La Tierra" sería inhabitable para cualquier forma de vida.',
	'Debido a esto, muchos morirían, pero gracias a la gran tecnología desarrollada por el ser humano, lograron salir 1000 naves del planeta con el objetivo de encontrar un nuevo mundo donde vivir',
	'De las 1000 naves la mayoría fueron destruidas por meteoritos o cuerpos celestes, unas pocas desaparecieron sin saber nada de su existencia y ninguna lograba encontrar una nueva "Tierra".',
	'Hasta que, por cosas del destino, una de las únicas naves supervivientes, chocó contra un meteorito y calló en el centro de este mundo desconocido y salvaje creado por "La niebla".'
]
var dialogElPueblo = [
	'La nave quedó destruida y aunque muchos murieron, gracias a los protocolos de salvamento de "La nave" consiguió salvar a 97 personas humanas y dirigir el choque hacia la zona menos peligrosa y con mas probabilidades de supervivencia humana.',
	'Antes de destruirse, "La Nave" detecto este mundo como habitable si se cumplían ciertas condiciones...',
	'Las personas supervivientes llamaron a ese nuevo mundo "Gaia" y con el paso de los años crearon un poblado a partir de los recursos de la nave y de los recursos cercanos, al poblado lo llamaron "MidTown".',
	'"Midtown" estaba situado en el punto central de "Gaia", estaba protegido por barreras naturales de peligros exteriores y en el se presentaban tres puertas, creadas para acceder a las tres zonas diferentes en que se dividía "Gaia"',
	'La vida en "Gaia" empezó apacible para la especie humana, pero con el paso de los años un mal se fue cerniendo sobre ellos hasta la actualidad.',
	'La especie humana no se ha expandido más allá del poblado, "Gaia" sigue estando mayoritariamente inexplorado y por alguna razón la esperanza de vida humana es menor cada generación.',
	'Es el año 702 desde el aterrizaje en "Gaia" y un joven cazador de "MidTown" no lo sabe, pero está a punto de emprender la mayor aventura que haya imaginado...'
]
var completed := false

@onready var control_dialog: Control = $ControlDialog
@onready var canvas_layer_transition: CanvasLayer = $CanvasLayerTransition

func _ready() -> void:
	completed = true
	contDialog = 0
	

func _process(delta: float) -> void:
	if completed:
		completed = false
		match contDialog:
			0:
				$ParallaxBackgroundLaNiebla.visible = true
				$ParallaxBackgroundLaNave.visible = false
				$ParallaxBackgroundElPueblo.visible = false
			1:
				$ParallaxBackgroundLaNiebla.visible = false
				$ParallaxBackgroundLaNave.visible = true
				$ParallaxBackgroundElPueblo.visible = false
			2:
				$ParallaxBackgroundLaNiebla.visible = false
				$ParallaxBackgroundLaNave.visible = false
				$ParallaxBackgroundElPueblo.visible = true
			3:
				get_tree().change_scene_to_file("res://Niveles/midtown.tscn")
		canvas_layer_transition.get_child(1).play_backwards("transition")
		await(canvas_layer_transition.get_child(1).animation_finished)
		match contDialog:
			0:
				control_dialog.completedialog = false
				control_dialog.dialog = dialogLaNiebla
				control_dialog.load_dialog()
			1:
				control_dialog.completedialog = false
				control_dialog.dialog = dialogLaNave
				control_dialog.load_dialog()
			2:
				control_dialog.completedialog = false
				control_dialog.dialog = dialogElPueblo
				control_dialog.load_dialog()
		
		


func _on_control_dialog_clear() -> void:
	contDialog += 1
	canvas_layer_transition.get_child(1).play("transition")
	await(canvas_layer_transition.get_child(1).animation_finished)
	completed = true
