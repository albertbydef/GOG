extends CanvasLayer

@onready var video_stream_player_salto: VideoStreamPlayer = $Panel/VBoxContainerSalto/VideoStreamPlayerSalto
@onready var video_stream_player_dialogos: VideoStreamPlayer = $Panel/VBoxContainerDialogos/VideoStreamPlayerDialogos
@onready var video_stream_player_caminar: VideoStreamPlayer = $Panel/VBoxContainerCaminar/VideoStreamPlayerCaminar
@onready var video_stream_player_salto_direc: VideoStreamPlayer = $Panel/VBoxContainerSaltoDirec/VideoStreamPlayerSaltoDirec
@onready var video_stream_player_disparo: VideoStreamPlayer = $Panel/VBoxContainerDisparo/VideoStreamPlayerDisparo
@onready var video_stream_player_tipo_flecha: VideoStreamPlayer = $Panel/VBoxContainerTipoFlecha/VideoStreamPlayerTipoFlecha
@onready var audio_stream_player_menu_select: AudioStreamPlayer = $AudioStreamPlayerMenuSelect
@onready var audio_stream_player_confirm: AudioStreamPlayer = $AudioStreamPlayerConfirm
@onready var audio_stream_player_exit: AudioStreamPlayer = $AudioStreamPlayerExit
@onready var audio_stream_player_atras: AudioStreamPlayer = $AudioStreamPlayerAtras



func _on_button_salir_pressed() -> void:
	audio_stream_player_exit.play()
	hide()
	$Panel/VBoxContainerSalto.show()
	$Panel/VBoxContainerCaminar.hide()
	$Panel/VBoxContainerSaltoDirec.hide()
	$Panel/VBoxContainerDisparo.hide()
	$Panel/VBoxContainerTipoFlecha.hide()
	$Panel/VBoxContainerDialogos.hide()
	get_parent().get_child(2).get_child(0).grab_focus()
	

func _on_video_stream_player_salto_finished() -> void:
	if $Panel/VBoxContainerSalto.visible == true:
		video_stream_player_salto.play()


func _on_video_stream_player_caminar_finished() -> void:
	if $Panel/VBoxContainerCaminar.visible == true:
		video_stream_player_caminar.play()


func _on_video_stream_player_salto_direc_finished() -> void:
	if $Panel.visible == true:
		video_stream_player_salto_direc.play()


func _on_button_atras_salto_direc_pressed() -> void:
	audio_stream_player_atras.play()
	$Panel/VBoxContainerSaltoDirec.hide()
	$Panel/VBoxContainerCaminar.show()
	video_stream_player_caminar.play()
	$Panel/VBoxContainerCaminar/HBoxContainer2/ButtonAtrasCaminar.grab_focus()


func _on_button_siguiente_salto_direc_pressed() -> void:
	audio_stream_player_confirm.play()
	$Panel/VBoxContainerSaltoDirec.hide()
	$Panel/VBoxContainerDisparo.show()
	video_stream_player_disparo.play()
	$Panel/VBoxContainerDisparo/HBoxContainer2/ButtonSiguienteDisparo.grab_focus()


func _on_button_atras_caminar_pressed() -> void:
	audio_stream_player_atras.play()
	$Panel/VBoxContainerCaminar.hide()
	$Panel/VBoxContainerSalto.show()
	video_stream_player_salto.play()
	$Panel/VBoxContainerSalto/ButtonSiguienteSalto.grab_focus()


func _on_button_siguiente_caminar_pressed() -> void:
	audio_stream_player_confirm.play()
	$Panel/VBoxContainerCaminar.hide()
	$Panel/VBoxContainerSaltoDirec.show()
	video_stream_player_salto_direc.play()
	$Panel/VBoxContainerSaltoDirec/HBoxContainer2/ButtonSiguienteSaltoDirec.grab_focus()


func _on_button_siguiente_salto_pressed() -> void:
	audio_stream_player_confirm.play()
	$Panel/VBoxContainerSalto.hide()
	$Panel/VBoxContainerCaminar.show()
	video_stream_player_caminar.play()
	$Panel/VBoxContainerCaminar/HBoxContainer2/ButtonSiguienteCaminar.grab_focus()
	


func _on_video_stream_player_disparo_finished() -> void:
	if $Panel/VBoxContainerDisparo.visible == true:
		video_stream_player_disparo.play()


func _on_button_atras_disparo_pressed() -> void:
	audio_stream_player_atras.play()
	$Panel/VBoxContainerDisparo.hide()
	$Panel/VBoxContainerSaltoDirec.show()
	video_stream_player_salto_direc.play()
	$Panel/VBoxContainerSaltoDirec/HBoxContainer2/ButtonAtrasSaltoDirec.grab_focus()


func _on_button_siguiente_disparo_pressed() -> void:
	audio_stream_player_confirm.play()
	$Panel/VBoxContainerDisparo.hide()
	$Panel/VBoxContainerTipoFlecha.show()
	video_stream_player_tipo_flecha.play()
	$Panel/VBoxContainerTipoFlecha/HBoxContainer2/ButtonSiguienteTipoFlecha.grab_focus()


func _on_video_stream_player_tipo_flecha_finished() -> void:
	if $Panel/VBoxContainerTipoFlecha.visible == true:
		video_stream_player_tipo_flecha.play()


func _on_button_atras_tipo_flecha_pressed() -> void:
	audio_stream_player_atras.play()
	$Panel/VBoxContainerTipoFlecha.hide()
	$Panel/VBoxContainerDisparo.show()
	video_stream_player_disparo.play()
	$Panel/VBoxContainerDisparo/HBoxContainer2/ButtonAtrasDisparo.grab_focus()


func _on_button_siguiente_tipo_flecha_pressed() -> void:
	audio_stream_player_confirm.play()
	$Panel/VBoxContainerTipoFlecha.hide()
	$Panel/VBoxContainerDialogos.show()
	video_stream_player_dialogos.play()
	$Panel/VBoxContainerDialogos/ButtonAtrasDialogos.grab_focus()


func _on_video_stream_player_dialogos_finished() -> void:
	if $Panel/VBoxContainerDialogos.visible == true:
		video_stream_player_dialogos.play()


func _on_button_atras_dialogos_pressed() -> void:
	audio_stream_player_atras.play()
	$Panel/VBoxContainerDialogos.hide()
	$Panel/VBoxContainerTipoFlecha.show()
	video_stream_player_tipo_flecha.play()
	$Panel/VBoxContainerTipoFlecha/HBoxContainer2/ButtonAtrasTipoFlecha.grab_focus()


func _on_button_siguiente_salto_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_salir_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_atras_caminar_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_siguiente_caminar_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_atras_salto_direc_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_siguiente_salto_direc_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_atras_disparo_focus_exited() -> void:
	if audio_stream_player_atras.playing == false or audio_stream_player_confirm.playing == false or audio_stream_player_exit.playing == false:
		audio_stream_player_menu_select.play()


func _on_button_siguiente_disparo_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_atras_tipo_flecha_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_siguiente_tipo_flecha_focus_exited() -> void:
	audio_stream_player_menu_select.play()


func _on_button_atras_dialogos_focus_exited() -> void:
	audio_stream_player_menu_select.play()
