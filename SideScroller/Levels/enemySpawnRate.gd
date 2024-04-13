extends Node


@export var spawn_rate = 0.1
@export var flying_spawn_rate = 0
@export var ground_spawn_rate = 0

func get_spawn_rate() -> float:
	return spawn_rate
	
func get_flying_enemy_spawn_rate() -> float:
	return flying_spawn_rate
	
func get_ground_enemy_spawn_rate() -> float:
	return ground_spawn_rate
