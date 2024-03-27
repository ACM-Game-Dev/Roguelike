extends Node2D

@export var parallax_strength: float = 10 # Lower is stronger!!
@export var player: Node = null # Initialize player as null
var original_player_pos: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player and player.global_position:
		var player_movement = player.global_position - original_player_pos
		global_position.x -= player_movement.x / parallax_strength
		original_player_pos = player.global_position  # Update the original position for the next frame
	else:
		print("Player is not valid or does not have a global_position.")
