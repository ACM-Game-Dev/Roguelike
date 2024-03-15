extends Node

@export var rooms:Array[PackedScene]
@export var min_rooms = 0
@export var max_rooms = rooms.size()


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_rooms()
	pass # Replace with function body.

func generate_rooms():
	var num_rooms = randi() % (max_rooms - min_rooms + 1) + min_rooms
	var prev_exitPoint = get_node("FirstEntry").global_position
	
	for i in range(num_rooms):
		var randRoom = randi() % rooms.size()
		var newRoom = rooms[randRoom].instantiate()
		add_child(newRoom)
		
		if i == 0:
			var entry_point = newRoom.get_node("EntryPoint").global_position
			newRoom.global_position += prev_exitPoint - entry_point
			prev_exitPoint = newRoom.get_node("ExitPoint").global_position
		else:
			var entry_point = newRoom.get_node("EntryPoint").global_position
			newRoom.global_position += prev_exitPoint - entry_point
			prev_exitPoint = newRoom.get_node("ExitPoint").global_position
	
