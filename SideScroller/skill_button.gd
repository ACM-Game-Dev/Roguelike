extends TextureButton

class_name SkillButton

@export var enabled: bool = false
@export var upgrade_name: String
@export var connected: Array[SkillButton] = []

var player = null

func style_text():
	if enabled:
		%Points.set("theme_override_colors/font_color",Color(1,1,1,1))
	else:
		%Points.set("theme_override_colors/font_color",Color(0.5,0.5,0.5,1))

func _ready():
	player = Globals.get_player()
	style_text()

func _on_button_down():
	if not enabled:
		return
	
	var postRun = player.postRunResource
	if postRun.skill_points > 0:
		postRun.skill_points -= 1
		print(postRun.skill_points)
	else: 
		return

	%Points.text = "1/1"
	for button in connected:
		button.set_enabled()


func set_enabled():
	enabled = true
	style_text()
