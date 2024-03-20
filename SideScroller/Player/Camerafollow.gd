extends Camera2D

var centerpoint = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body



func _process(delta):
	var player_location = get_parent().global_position
	centerpoint = player_location + (get_global_mouse_position() - player_location) / 10
	global_position = lerp(global_position,centerpoint,0.2)
