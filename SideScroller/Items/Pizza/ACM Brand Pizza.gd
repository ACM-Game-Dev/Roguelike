extends Item

class_name ACM_BRAND_PIZZA

func equip(player:Player):
	var player_stats: PlayerStats = player.playerStats
	player_stats.MAX_HEALTH += 25
	return

func unequip(player:Player):
	pass
