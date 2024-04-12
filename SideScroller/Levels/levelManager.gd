extends Node

@export var levels: Array[NodePath] = []
@export var player: Node2D
var current_level_index = 0

func _ready():
	if levels.size() > 0:
		teleport_to_level(0)  

func teleport_to_level(index: int):
	if index < 0 or index >= levels.size():
		print("Invalid level index.")
		return

	current_level_index = index
	var level_node = get_node_or_null(levels[current_level_index])
	if level_node:
		var spawn_position = level_node.get_spawn_point()
		player.global_position = spawn_position
		print("Teleported to level: ", level_node.name, " at position: ", spawn_position)
	else:
		print("Level node not found.")

func enter_next_level():
	if current_level_index + 1 < levels.size():
		print("Switching to the next level with player: ", player.name)
		teleport_to_level(current_level_index + 1)
	else:
		print("No more levels. Returning to the first level.")
		teleport_to_level(0)

func return_to_lobby():
	print("Returning to the lobby with player: ", player.name)
	teleport_to_level(0)  
	
	
