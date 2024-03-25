extends CharacterBody2D

class_name Player

signal health_changed

@export var playerStats: PlayerStats
@export var itemCount: ItemCount

@onready var equipment_list = %Equipment.get_children()
@onready var sprite = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_equipment: int = 0
var curr_weapon: String
var attacking = false

func _ready():
	curr_weapon = "Sword1"

func update_animation_parameters():
	if velocity.x < -0.1:
		sprite.flip_h = true
	elif velocity.x > 0.1:
		sprite.flip_h = false
	
	# Checking conditionals to set animations 
	if is_on_floor() && (velocity == Vector2.ZERO) && !attacking:
		sprite.play("Idle")
	elif is_on_floor() && (velocity != Vector2.ZERO) && !attacking:
		sprite.play("Walk")
	elif !is_on_floor() && !attacking:
		sprite.play("Jump")

func attack_animation():
	attacking = true
	sprite.play(curr_weapon)
	await get_tree().create_timer(1).timeout
	attacking = false
	
func equip_item(item: Item):
	itemCount.itemCountDict[item.name] += 1
	item.equip(self)
	print(playerStats)
	print(itemCount)

func take_damage(val: int):
	playerStats.CURR_HEALTH -= val
	print(playerStats.CURR_HEALTH)
	health_changed.emit()
	if playerStats.CURR_HEALTH <= 0: # Handling death
		player_death()

func player_death():
	print("Dead!") # On death, right now just resets the current scene
	get_tree().reload_current_scene()

func use_equipment():
	if Input.is_action_just_pressed("attack"):
		var curr_equipment = equipment_list[current_equipment]
		curr_equipment.activate(self)
		attack_animation()
		print(curr_equipment.name)

func jump_and_fall(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = playerStats.JUMP_POWER

func move_horizontal():
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * playerStats.MOVE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, playerStats.MOVE_SPEED)

func _physics_process(delta):
	jump_and_fall(delta)
	
	update_animation_parameters()
	use_equipment()
	move_horizontal()
		
	move_and_slide()
