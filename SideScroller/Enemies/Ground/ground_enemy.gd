extends CharacterBody2D

class_name GroundEnemy

@onready var player: Player = Globals.player

@export var enemy_resource: Enemy_Resource

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var health: int
var is_stunned = false
var stun_timer: float = .5
var damaging = false
var direction = Vector2.RIGHT
var distance = 100
var range = 150

var found = false

var silver_reward = 15
var xp_reward = 10

func _ready():
	health = enemy_resource.health

func _physics_process(delta):
	if is_stunned:
		#velocity = Vector2.ZERO # While stunned, cannot move
		move_and_slide()
		velocity /= 1.1
		return
	
	# Apply gravity to enemy
	velocity.y += gravity * delta
	
	# Swap sprite based on movement direction
	if velocity.x < 0:
		%AnimatedSprite2D.flip_h = false
	else:
		%AnimatedSprite2D.flip_h = true
	
	if not player:
		return
	
	if player:
		
		distance = (player.global_position - global_position).length()
		if distance < range:
			
			direction = (player.global_position - global_position).normalized()
			velocity.x = enemy_resource.speed * direction.x * delta
			if !$GroundEnemySounds.is_playing():
				$GroundEnemySounds.play()

	if damaging:
		player.take_damage(enemy_resource.damage)

	move_and_slide()

func enemy_take_damage(damage, params: Dictionary):
	health -= damage
	is_stunned = true #primitive "feedback", when enemy gets hit, halts movement 
	for param in params:
		if param == "knockback":
			velocity = params["knockback"]
			print(params["knockback"])
			
	print(velocity)
	print(health)
	if health <= 0:
		player.runResource.silver += silver_reward
		player.runResource.xp += xp_reward
		player.silver_changed.emit()
		queue_free() # Die
	await get_tree().create_timer(stun_timer).timeout
	is_stunned = false #stun to false after half a second

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true


func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false
