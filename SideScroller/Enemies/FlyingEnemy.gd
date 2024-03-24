extends CharacterBody2D

class_name FlyingEnemy

@export var enemy_resource: Enemy_Resource

@export var player: Player
var direction = Vector2.RIGHT
var damaging = false

func _ready():
	if !player:
		player = get_parent().get_node("CharacterBody2D")

func _physics_process(delta):
	if player:
		direction = (player.global_position - global_position).normalized()
		velocity = enemy_resource.speed * direction * delta
		#print(velocity)

	if velocity.x > 0:
		%AnimatedSprite2D.flip_h = false
	else:
		%AnimatedSprite2D.flip_h = true

	if damaging:
		player.take_damage(enemy_resource.damage)
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true

func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false
