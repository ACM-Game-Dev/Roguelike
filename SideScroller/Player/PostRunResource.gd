extends Resource

class_name PostRunResource

@export var upgrades: Dictionary
@export var skill_points: int

func format_save():
	var data = {
		"skill_points": skill_points,
		"upgrades": upgrades
	}
	return data
