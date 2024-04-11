extends CharacterBody2D

class_name GroundEnemy

@export var player: Player
@export var enemy_resource: Enemy_Resource

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var health: int
var is_stunned = false
var stun_timer: float = .5
var damaging = false
var direction = Vector2.RIGHT
var distance = 100
var range = 150

func _ready():
	health = enemy_resource.health
	if !player:
		player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if is_stunned:
		velocity = Vector2.ZERO #While stunned, cannot move
		return
	
	if player:
		distance = (player.global_position - global_position).length()
		
		if distance < range:
			direction = (player.global_position - global_position).normalized()
			velocity.x = enemy_resource.speed * direction.x * delta
			velocity.y += gravity * delta
	if velocity.x < 0:
		%AnimatedSprite2D.flip_h = false
	else:
		%AnimatedSprite2D.flip_h = true

	if damaging:
		player.take_damage(enemy_resource.damage)

	move_and_slide()

func enemy_take_damage(damage):
	health -= damage
	is_stunned = true #primitive "feedback", when enemy gets hit, halts movement 
	print(health)
	if health <= 0:
		print("Ground Enemy Dead!")
		queue_free() #Die
	await get_tree().create_timer(stun_timer).timeout
	is_stunned = false #stun to false after half a second

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true


func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false
