extends Node

@export var spawn_points: Array[NodePath] = []  
var player: Node = null
var enemy_spawn_rate_node: Node = null 
var has_player_triggered_spawn = false

var flying_enemy_scene = preload("res://Enemies/Flying/flying_enemy.tscn")
var ground_enemy_scene = preload("res://Enemies/Ground/ground_enemy.tscn")

func _ready():
	player = get_node_or_null("/root/MainStage/Player")  
	enemy_spawn_rate_node = get_node_or_null("/root/MainStage")  
	
	if player:
		print("Got player")
	else:
		print("No player found")

func trigger_spawn(body):
	if body == player and not has_player_triggered_spawn:
		spawn_enemies()
		has_player_triggered_spawn = true
		print("Should spawn enemies!!")

func spawn_enemies():
	var rate = enemy_spawn_rate_node.get_spawn_rate()
	var spawn_count = int(spawn_points.size() / 2)
	var chosen_points = []
	for path in spawn_points:
		chosen_points.append(get_node(path)) 

	chosen_points.shuffle() 
	for i in range(spawn_count):
		var spawn_position = chosen_points[i].global_position
		spawn_enemy_at(spawn_position)

func spawn_enemy_at(position):
	var flying_rate = enemy_spawn_rate_node.get_flying_enemy_spawn_rate()
	var ground_rate = enemy_spawn_rate_node.get_ground_enemy_spawn_rate()
	var total_rate = flying_rate + ground_rate

	if total_rate == 0:
		return 

	var spawn_threshold = flying_rate / total_rate
	var random_choice = randf()

	var enemy_instance
	if random_choice < spawn_threshold:
		enemy_instance = flying_enemy_scene.instantiate()
		print("Spawn flying enemy")
	else:
		enemy_instance = ground_enemy_scene.instantiate() 
		print("Spawn ground enemy")
		
	

	get_tree().root.call_deferred("add_child", enemy_instance)
	
	print("Enemy Spawned at", enemy_instance.global_position)
	enemy_instance.global_position = position
