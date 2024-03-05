extends Item

class_name ACM_BRAND_PIZZA

func equip(player:Player):
	var player_stats = player.get_stats()
	player_stats.max_health += 25
	return

func unequip(player:Player):
	pass
