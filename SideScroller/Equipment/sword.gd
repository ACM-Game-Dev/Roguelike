extends Equipment

class_name Sword

@export var weapon_resource: Weapon_Resource
var swings = 0
var cooledDown = true

func equip(player):
	# Replace player default anims with sword anims
	pass
	
func activate(player):
	if not cooledDown:
		return
	swings += 1
	if swings > 1:
		swings = 0
	cooledDown = false
	print("SWUNG")
	%Delay.start()
	
	

func drop(player):
	# Reset player animations to normal
	pass
	

func _on_delay_timeout():
	cooledDown = true
	print("READY TO SWING")
