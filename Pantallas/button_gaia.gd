extends Button
class_name buttonGaia

func _on_pressed() -> void:
	$AudioStreamPlayerConfirm.play()



func _on_focus_exited() -> void:
	$AudioStreamPlayerMenuSelect.play()
