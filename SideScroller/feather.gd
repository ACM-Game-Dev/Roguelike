extends Item

class_name feather

func equip(player:Player):
	var player_stats = player.get_stats()
	player_stats.speed += 5 0
	return

func unequip(player:Player):
	pass
