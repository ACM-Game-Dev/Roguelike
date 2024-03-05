extends CharacterBody2D

class_name Player

var stats = {
	max_health = 100,
	speed = 300.0,
	jump_power = -400.0,
	jumps = 1
}

var item_counts = {
	"ACM_BRAND_PIZZA" : 0,
	"feather": 0
}

func equip_item(item: Item):
	item_counts[item.name] += 1
	item.equip(self)
	print(stats)
	print(item_counts)

func get_stats():
	return stats

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = stats.jump_power

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * stats.speed
	else:
		velocity.x = move_toward(velocity.x, 0, stats.speed)

	move_and_slide()
