extends CharacterBody2D

class_name FlyingEnemy

@export var enemy_resource: Enemy_Resource

@onready var player: Player = Globals.player
@onready var target: CharacterBody2D
@onready var nav_agent: NavigationAgent2D = %NavigationAgent2D

var direction = Vector2.RIGHT
var damaging = false
var in_range = false

func _ready():
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4


func _physics_process(delta):
	if in_range and target:
		nav_agent.target_position = target.global_position
		print("NEW TARGET POS")
	
	if nav_agent.is_navigation_finished():
		print("FINISHED")
		return
	
	var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	velocity = direction * enemy_resource.speed * delta

	if velocity.x < 0:
		%AnimatedSprite2D.flip_h = false
	else:
		%AnimatedSprite2D.flip_h = true


	if damaging and player:
		player.take_damage(enemy_resource.damage)

	move_and_slide()
	
func take_damage_enemy(val: int):
	enemy_resource.health -= val
	# Check for enemy death
	died()

func died():
	if enemy_resource.health < 1:
		player.gain_silver(enemy_resource.silver)
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true

func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false

func _on_range_body_entered(body):
	if body == player:
		if !target: 
			target = body
		in_range = true
		if !$BeeSounds.is_playing():
			$BeeSounds.play()
		

func _on_range_body_exited(body):
	if body == player:
		$BeeSounds.stop()
		if target:
			target = null
		in_range = false

