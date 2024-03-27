extends Area2D

var player: Node = null
var label = null

func _ready():
	player = get_node_or_null("../../../Player")
	label = get_node_or_null("EnterDoorText")
	label.visible = false
	
	if player:
		print("Player got")
	else:
		print("Missing player")
		
	print("Area2D Collision Layer: ", collision_layer, " Mask: ", collision_mask)
	if player:
		print("Player Collision Layer: ", player.collision_layer, " Mask: ", player.collision_mask)

func _on_Door_Entered(area):
	if area == player: 
		label.visible = true
		print("Player is in the gateway")


func _on_Door_Exited(area):
	if area == player:
		label.visible = false
		print("Player is not in the gateway")
		
# This function is called every frame, which checks for player interaction
func _process(delta):
	if label.visible and Input.is_action_just_pressed("interact"): 
		print("Player is entering the door...")


