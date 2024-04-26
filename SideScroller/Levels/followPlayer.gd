extends Node2D

@export var player: Node2D

func _ready():
	if player == null:
		print("Player node not found!")

func _process(delta):
	if player:
		position = player.position
	else:
		print("Player is not valid or does not have a global_position.")
