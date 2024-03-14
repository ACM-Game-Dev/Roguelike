extends CharacterBody2D

class_name Player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_tree: AnimationTree = %AnimationTree

var stats = {
	max_health = 100,
	speed = 150.0,
	jump_power = -400.0,
	jumps = 1
}

var item_counts = {
	"ACM_BRAND_PIZZA" : 0,
	"feather": 0
}

func _ready():
	anim_tree.active = true

func update_animation_parameters():
	if velocity.x < -0.1:
		%PlayerSprite.flip_h = true
	elif velocity.x > 0.1:
		%PlayerSprite.flip_h = false
	
	if velocity == Vector2.ZERO:
		anim_tree["parameters/conditions/idle"] = true
		anim_tree["parameters/conditions/is_moving"] = false
	else:
		anim_tree["parameters/conditions/is_moving"] = true
		anim_tree["parameters/conditions/idle"] = false
	
	if(Input.is_action_just_pressed("attack")):
		anim_tree["parameters/conditions/swing"] = true
	else:
		anim_tree["parameters/conditions/swing"] = false
	
	
func equip_item(item: Item):
	item_counts[item.name] += 1
	item.equip(self)
	print(stats)
	print(item_counts)

func get_stats():
	return stats


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = stats.jump_power
	
	update_animation_parameters()


	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * stats.speed
	else:
		velocity.x = move_toward(velocity.x, 0, stats.speed)

	move_and_slide()
