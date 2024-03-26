extends Node2D
@export var player_path: NodePath
@export var parallax_strength: float = 10 #Lower is stronger!!
var player = Node2D
var original_player_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	#Get player node
	player = get_node(player_path)
	#Checks for if player is valid
	if player and player_path:
		#Get starting player position
		original_player_pos = player.global_position
	else:
		print("Player character is invalid")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player and player.global_position:
		#Get how much player has moved
		var player_movement = player.global_position - original_player_pos
		#Parallax calculation for moving the object in comparison to player distance moved
		#and parallax strength 
		global_position.x = original_player_pos.x - player_movement.x / parallax_strength
	else:
		print("Player is not valid or does not have a global_position.")
