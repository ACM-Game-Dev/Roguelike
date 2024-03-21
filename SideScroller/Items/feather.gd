extends Item

class_name feather

func equip(player:Player):
	var player_stats: PlayerStats = player.playerStats
	player_stats.MOVE_SPEED += 50 
	return

func unequip(player:Player):
	pass
