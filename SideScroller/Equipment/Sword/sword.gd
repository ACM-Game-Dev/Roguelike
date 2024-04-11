extends Equipment

class_name Sword

@export var weapon_resource: Weapon_Resource
@onready var hitbox1 = $AttackArea1/CollisionShape2D
@onready var hitbox2 = $AttackArea2/CollisionShape2D
var swings = 0
var cooledDown = true

func equip(player):
	#Since this is going to be (practically) the same across all weapons, could it be done in Equipment.gd? 
	#Idk how that will work with the Resources
	print("Sword Equipped!")
	player.curr_weapon = weapon_resource.equipment_name
	player.idle_anim = weapon_resource.idle_anim
	player.attack_anim = weapon_resource.activate_anim
	hitbox1.disabled = true
	hitbox2.disabled = true
	
func activate(player):
	if not cooledDown:
		return
		
	rotate_hitbox(player)
	
	swings += 1
	# We change the player's attack animation depending on the current state of our sword combo
	if swings == 1:
		player.attack_anim = weapon_resource.activate_anim
		hitbox1.disabled = false
	elif swings == 2:
		player.attack_anim = "Sword_Swing2" 
		hitbox2.disabled = false
	elif swings > 2:
		player.attack_anim = "Sword_Swing3"
		hitbox1.disabled = false #The motion for 3 is similar to 1, hence reusing the same hitbox
		
	cooledDown = false
	player.attack_animation() # Playing the player's attack animation
	print("SWORD SWUNG")
	
	# Resetting if we exceed our combo (3 swings) and starting the attack delay
	if swings >= 3:
		swings = 0
	await get_tree().create_timer(weapon_resource.attack_delay).timeout
	hitbox1.disabled = true
	hitbox2.disabled = true
	cooledDown = true
	print("READY TO SWING SWORD")
	
	
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
	if body.has_method("enemy_take_damage"):
		if swings == 1: #Combo 1
			body.enemy_take_damage(weapon_resource.damage)
		elif swings == 3: #Combo 3
			body.enemy_take_damage(weapon_resource.damage + 10)


func hitbox2_detection(body):
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage(weapon_resource.damage + 5) #Combo 2
	
