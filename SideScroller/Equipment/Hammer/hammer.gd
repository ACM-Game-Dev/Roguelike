extends Equipment

class_name Hammer

@export var weapon_resource: Weapon_Resource
@onready var hitbox = $Area2D/CollisionShape2D
var cooledDown = true

func equip(player):
	#Since this is going to be (practically) the same across all weapons, could it be done in Equipment.gd? 
	#Idk how that will work with the Resources
	print("Hammer Equipped!")
	player.curr_weapon = weapon_resource.equipment_name
	player.idle_anim = weapon_resource.idle_anim
	player.attack_anim = weapon_resource.activate_anim
	hitbox.disabled = true
	
func activate(player):
	if not cooledDown:
		return
		
	rotate_hitbox(player)
		
	cooledDown = false
	player.attack_animation() # Playing the player's attack animation
	hitbox.disabled = false
	print("HAMMER SWUNG")
	await get_tree().create_timer(1).timeout #Keeps the hitbox active for the duration of the animation
	hitbox.disabled = true
	await get_tree().create_timer(weapon_resource.attack_delay - 1).timeout #We subtract the amount of time the hitbox was active for
	
	cooledDown = true
	print("READY TO SWING HAMMER")
	
	
func rotate_hitbox(player):
	#Checks if the player is facing the opposite direciton
	if player.sprite.flip_h:
		self.scale.x = -1
	else:
		self.scale.x = 1
		
func drop(player):
	# Reset player animations to normal
	pass


func hitbox1_detection(body):
	#Do damage to thing
	pass # Replace with function body.
