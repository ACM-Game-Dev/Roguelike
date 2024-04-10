extends CharacterBody2D

class_name Player

signal health_changed(int)
signal silver_changed(int)

@export var playerStats: PlayerStats
@export var itemCount: ItemCount
@export var playerResources: RunResource
@export var postRunResources: PostRunResource

@onready var anim_tree: AnimationTree = %AnimationTree
@onready var equipment_list = %Equipment.get_children()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_equipment: int = 0
var saveFile = "user://saves/01.data"
func load_post_run_resources():
	var prev_resources: PostRunResource = load("user://01_save.tres")
	postRunResources = prev_resources
	
	print(str(postRunResources))


func _ready():
	load_post_run_resources()
	anim_tree.active = true
	Globals.player = self

func update_animation_parameters():
	if velocity.x < -0.1:
		%PlayerSprite.flip_h = true
	elif velocity.x > 0.1:
		%PlayerSprite.flip_h = false
	
	# Checking conditionals to set animations 
	anim_tree.set("parameters/conditions/idle", is_on_floor() && (velocity == Vector2.ZERO))
	anim_tree.set("parameters/conditions/is_moving", is_on_floor() && (velocity != Vector2.ZERO))
	anim_tree.set("parameters/conditions/is_jumping", !is_on_floor())
	anim_tree.set("parameters/conditions/swing", Input.is_action_just_pressed("attack"))

func equip_item(item: Item):
	itemCount.itemCountDict[item.name] += 1
	item.equip(self)
	print(playerStats)
	print(itemCount)

func take_damage(val: int):
	playerStats.CURR_HEALTH -= val
	print(playerStats.CURR_HEALTH)
	health_changed.emit(playerStats.CURR_HEALTH)
	if playerStats.CURR_HEALTH <= 0: # Handling death
		player_death()

func gain_silver(val: int): 
	playerResources.silver += val
	print("Gained silver!: " + str(val))
	print("Silver: " + str(playerResources.silver))
	silver_changed.emit(playerResources.silver)

func player_death():
	print("Dead!") # On death, right now just resets the current scene
	get_tree().reload_current_scene()

func use_equipment():
	if Input.is_action_just_pressed("attack"):
		var curr_equipment = equipment_list[current_equipment]
		curr_equipment.activate(self)
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
