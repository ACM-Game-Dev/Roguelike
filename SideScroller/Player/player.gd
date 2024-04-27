extends CharacterBody2D

class_name Player

signal health_changed(int)
signal silver_changed(int)
signal xp_changed(int)

@export var playerStats: PlayerStats
@export var itemCount: ItemCount

@export var runResource: RunResource
@export var postRunResource: PostRunResource

@onready var equipment_list = %Equipment.get_children()
@onready var sprite = $AnimatedSprite2D
@onready var anim_player = $AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_equipment: int = 2 #0 = Sword, 1 = Hammer, 2 = Bow
var attacking = false

#These are set in equip() of the weapon we are using
var curr_weapon: String
var idle_anim: String 
var attack_anim: String 
var save_path = "user://save_1.tres"

func load_post_run():
	LoadSaver.load_player_resource(self)
	#print("Skill points: " + str(postRunResource.skill_points))

func _ready():
	# This is only here so we spawn with a weapon. Right now, we never "encounter" a weapon
	reequip()
	Globals.player = self
	#load_post_run()
	print(postRunResource)

func update_animation_parameters():
	if velocity.x < -0.1:
		sprite.flip_h = true
	elif velocity.x > 0.1:
		sprite.flip_h = false
	
	# Checking conditionals to set animations 
	if is_on_floor() && (velocity == Vector2.ZERO) && !attacking:
		sprite.play(idle_anim)
	elif is_on_floor() && (velocity != Vector2.ZERO) && !attacking:
		sprite.play("Walk")
	elif !is_on_floor() && !attacking:
		sprite.play("Jump")

func attack_animation():
	attacking = true
	sprite.play(attack_anim)
	#If this delay is not here, the swing animation will be immediately overwritten
	await get_tree().create_timer(.7).timeout # .7s just kinda feels right 
	attacking = false
	
func equip_item(item: Item):
	itemCount.itemCountDict[item.name] += 1
	item.equip(self)
	print(playerStats)
	print(itemCount)

func take_damage(val: int):
	playerStats.CURR_HEALTH -= val
	#print(playerStats.CURR_HEALTH)
	health_changed.emit()
	if playerStats.CURR_HEALTH <= 0: # Handling death
		player_death()

func player_death():
	print("Dead!") # On death, right now just resets the current scene
	Globals.player = null
	get_tree().reload_current_scene()

func use_equipment():
	equipment_list[current_equipment].activate(self)
	print(equipment_list[current_equipment].name)

func reequip():
	equipment_list[current_equipment].equip(self)

func change_equipment():
	if Input.is_action_just_pressed("equip_1"):
		current_equipment = 0
		%Equipment1.button_pressed = true
		%Equipment2.button_pressed = false
		%Equipment3.button_pressed = false
	elif Input.is_action_just_pressed("equip_2"):
		current_equipment = 1
		%Equipment2.button_pressed = true
		%Equipment1.button_pressed = false
		%Equipment3.button_pressed = false
	elif Input.is_action_just_pressed("equip_3"):
		current_equipment = 2
		%Equipment3.button_pressed = true
		%Equipment2.button_pressed = false
		%Equipment1.button_pressed = false
	else:
		return
	reequip()

func get_animation():
	return $AnimatedSprite2D

func jump_and_fall(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#postRunResource.skill_points += 1
		#print(postRunResource.skill_points)
		velocity.y = playerStats.JUMP_POWER

func move_horizontal():
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * playerStats.MOVE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, playerStats.MOVE_SPEED)
	
	move_and_slide()

func _physics_process(delta):
	jump_and_fall(delta)
	move_horizontal()
	update_animation_parameters()
	change_equipment()
	
	if Input.is_action_just_pressed("attack"): # Moved this conditional here so we are not calling use_equipment every frame
		use_equipment()
