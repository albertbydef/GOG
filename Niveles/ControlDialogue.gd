extends Control
class_name Dialog

var dialog : Array
var tween : Tween
var dialog_index := 0
var text_speed := 0.05
var tween_duration : float
var finished := false
var completedialog := false

signal clear

@onready var rich_text_label_dialog: RichTextLabel = $RichTextLabelDialog
@onready var audio_stream_player_confirm: AudioStreamPlayer = $AudioStreamPlayerConfirm


func _ready() -> void:
	$RichTextLabelDialog.bbcode_enabled = true
	$RichTextLabelDialog.text += ''

func _process(delta: float) -> void:
	$TextureRectNext.visible = finished if !completedialog else false
	if Input.is_action_just_pressed("ui_accept") and !completedialog:
		audio_stream_player_confirm.play()
		if finished:
			load_dialog()
		elif tween != null:
			tween.stop()
			$RichTextLabelDialog.visible_ratio = 1
			finished = true
		else:
			pass

func load_dialog():
	$TextureRectDialog.visible = true
	$RichTextLabelDialog.visible = true
	if dialog_index < dialog.size():
		finished = false
		rich_text_label_dialog.bbcode_enabled = true
		rich_text_label_dialog.text = dialog[dialog_index]
		rich_text_label_dialog.visible_ratio = 0
		var tween_duration = text_speed * dialog[dialog_index].length()
		tween = get_parent().create_tween()
		tween.tween_property($RichTextLabelDialog, "visible_ratio", 1, tween_duration).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		tween.connect("finished", on_tween_finished)
		tween.play()
	else:
		$TextureRectDialog.visible = false
		$RichTextLabelDialog.visible = false
		completedialog = true
		finished = true
		dialog_index = -1
		dialog.clear()
		clear.emit()
	dialog_index += 1

func on_tween_finished():
	finished = true
