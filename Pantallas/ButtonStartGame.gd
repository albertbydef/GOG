extends buttonGaia
@onready var v_box_container_main_menu: VBoxContainer = $".."
@onready var v_box_container_levels: VBoxContainer = $"../../VBoxContainerLevels"
@onready var v_box_container_settings: VBoxContainer = $"../../VBoxContainerSettings"


func _on_pressed_start() -> void:
	v_box_container_main_menu.hide()
	v_box_container_levels.show()
	v_box_container_levels.get_child(0).get_child(0).get_child(1).grab_focus()
