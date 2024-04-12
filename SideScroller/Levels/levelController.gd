extends Node

var spawn_point: Node2D

func _ready():
	spawn_point = $PlayerSpawn
	if spawn_point:
		print("Spawn point found: ", name)
	else:
		print("PlayerSpawn node not found, please check your scene structure.")

func get_spawn_point() -> Vector2:
	if spawn_point:
		print("Returning spawn point position: ", spawn_point.global_position)
		return spawn_point.global_position
	else:
		print("Spawn point not available.", name)
		return Vector2.ZERO
