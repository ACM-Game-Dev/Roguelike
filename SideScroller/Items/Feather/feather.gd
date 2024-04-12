extends Item

class_name Feather
@export var item: Item  = self

func equip(player:Player):
	var player_stats: PlayerStats = player.playerStats
	player_stats.MOVE_SPEED += 50 
	return

func unequip(player:Player):
	pass


func _on_body_entered(body):
	if body.has_method("equip_item"):
		body.equip_item(item)
		queue_free()
