extends Equipment

class_name Sword

@export var weapon_resource: Weapon_Resource
var swings = 0
var cooledDown = true

func equip(player):
	#Since this is going to be (practically) the same across all weapons, could it be done in Equipment.gd? 
	#Idk how that will work with the Resources
	print("Sword Equipped!")
	player.curr_weapon = weapon_resource.equipment_name
	player.idle_anim = weapon_resource.idle_anim
	player.attack_anim = weapon_resource.activate_anim
	
func activate(player):
	if not cooledDown:
		return
		
	swings += 1
	# We change the player's attack animation depending on the current state of our sword combo
	if swings == 2:
		player.attack_anim = "Sword_Swing2" 
	elif swings > 2:
		player.attack_anim = "Sword_Swing3"
		
	cooledDown = false
	player.attack_animation() # Playing the player's attack animation
	print("SWORD SWUNG")
	
	# Resetting if we exceed our combo (3 swings) and starting the attack delay
	if swings >= 3:
		swings = 0
		player.attack_anim = weapon_resource.activate_anim
	await get_tree().create_timer(weapon_resource.attack_delay).timeout
	cooledDown = true
	print("READY TO SWING SWORD")
	
	

func drop(player):
	# Reset player animations to normal
	pass
