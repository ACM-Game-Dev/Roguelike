extends TextureButton

class_name SkillButton

@export var enabled: bool = false


@export var connected: Array[SkillButton] = []


func _on_button_down():
	if not enabled:
		return
	%Points.text = "1/1"
	for button in connected:
		button.set_enabled()


func set_enabled():
	enabled = true
