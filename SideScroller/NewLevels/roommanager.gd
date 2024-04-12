extends Node

@export var rooms:Array[PackedScene] #Array that hold all room nodes
@export var min_rooms = 0 #Min. anmount of rooms that will spawn
@export var max_rooms = rooms.size() #Max. amount of rooms that will spawn
@export var repeatablerooms = false #Can room spawns duplicate?
@export var startRoom:PackedScene
@export var finalRoom:PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_rooms()
	pass # Replace with function body.

func generate_rooms():
	var prev_exitPoint = get_node("FirstEntry").global_position
	
	if startRoom:
		var start_room_instance = startRoom.instantiate()
		add_child(start_room_instance)
		var entry_point = start_room_instance.get_node("EntryPoint").global_position
		# Set start room's position if you have a specific start point in the scene
		# For example, prev_exitPoint could be set to a specific entry location in your game world
		start_room_instance.global_position += prev_exitPoint - entry_point
		prev_exitPoint = start_room_instance.get_node("ExitPoint").global_position
		
	var available_rooms = rooms.duplicate() #Create a duplicate array of rooms so we can delete as we go if we dont want repeat
	var num_rooms = randi() % (max_rooms - min_rooms + 1) + min_rooms #Get random amt of room spawns 
	
	for i in range(num_rooms):
		if not repeatablerooms and available_rooms.size() == 0: #If we are out of unique rooms stop
			break
		var randIndex = randi() % available_rooms.size() #Get random room
		var newRoom = available_rooms[randIndex].instantiate() #Create room
		add_child(newRoom)
		
		if not repeatablerooms:
			available_rooms.remove_at(randIndex) #Remove room from list so it doesnt duplicate
		
		var entry_point = newRoom.get_node("EntryPoint").global_position #Get new entry point
		newRoom.global_position += prev_exitPoint - entry_point #Set rooms entry point to be last rooms exit point
		prev_exitPoint = newRoom.get_node("ExitPoint").global_position #Set new exit point for new room
	
	var final_room_instance = finalRoom.instantiate()
	add_child(final_room_instance)
	var entry_point = final_room_instance.get_node("EntryPoint").global_position
	final_room_instance.global_position += prev_exitPoint - entry_point
	
	
