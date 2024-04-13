extends Area2D

var player: Node = null
var label = null
var playerInGateway = false

@onready var skill_tree_scene = preload("res://skill_tree.tscn")


func _ready():
	player = get_node_or_null("/root/MainStage/Player")
	label = get_node_or_null("EnterDoorText")
	label.visible = false
	
	print("Area2D Collision Layer: ", collision_layer, " Mask: ", collision_mask)
	if player:
		print("Player Collision Layer: ", player.collision_layer, " Mask: ", player.collision_mask)
		
func _process(delta):
	if playerInGateway and Input.is_action_just_pressed("interact"):
		var skills = skill_tree_scene.instantiate()
		player.get_node("PlayerGUI").add_child(skills)
		skills.z_index = 10

func _on_Door_Entered(area):
	if area == player: 
		label.visible = true
		playerInGateway = true
		print("Player is in the gateway")

func _on_Door_Exited(area):
	if area == player:
		label.visible = false
		playerInGateway = false
		print("Player is not in the gateway")
		


