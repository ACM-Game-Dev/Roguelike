extends TextureButton

class_name SkillButton

@export var enabled: bool = false


@export var connected: Array[SkillButton] = []

func style_text():
	if enabled:
		%Points.set("theme_override_colors/font_color",Color(1,1,1,1))
	else:
		%Points.set("theme_override_colors/font_color",Color(0.5,0.5,0.5,1))

func _ready():
	style_text()

func _on_button_down():
	if not enabled:
		return
	%Points.text = "1/1"
	for button in connected:
		button.set_enabled()


func set_enabled():
	enabled = true
	style_text()
