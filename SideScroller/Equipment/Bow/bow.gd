extends Equipment


class_name Bow

@export var weapon_resource: Weapon_Resource
var arrowScene = preload("res://Equipment/Bow/arrow.tscn")
var cooledDown = true

func equip(player):
	#Since this is going to be (practically) the same across all weapons, could it be done in Equipment.gd? 
	#Idk how that will work with the Resources
	print("Bow Equipped!")
	player.curr_weapon = weapon_resource.equipment_name
	player.idle_anim = weapon_resource.idle_anim
	player.attack_anim = weapon_resource.activate_anim
	
func activate(player):
	if not cooledDown:
		return

	cooledDown = false
	player.attack_animation() # Playing the player's attack animation
	var arrow = arrowScene.instantiate()
	get_parent().get_parent().add_child(arrow)
	if player.sprite.flip_h:
		arrow.SPEED *= -1
		arrow.arrow_sprite.flip_h = true
	print("BOW SHOT")
	
	await get_tree().create_timer(weapon_resource.attack_delay).timeout
	cooledDown = true
	print("READY TO SHOOT BOW")
	


func drop(player):
	# Reset player animations to normal
	pass
