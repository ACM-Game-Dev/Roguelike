extends Area2D

var player: Node = null
var label = null

func _ready():
	player = get_node("../../../Player")
	label = get_node("EnterDoorText")
	label.visible = false
	
	if player:
		print("Player got")
	else:
		print("Missing player")

func _on_Door_area_entered(area):
	if area.is_in_group(player): 
		label.visible = true
		# Optional: start fade-in animation here if you have one

func _on_Door_area_exited(area):
	if area.is_in_group(player):
		label.visible = false
		# Optional: start fade-out animation here if you have one

func _process(delta):
	if label.visible and Input.is_action_just_pressed("interact"): 
		print("Player is entering the door...")
		# Add your logic here for what happens when the player enters the door
