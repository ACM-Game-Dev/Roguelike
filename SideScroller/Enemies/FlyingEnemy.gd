extends CharacterBody2D

class_name FlyingEnemy

const SPEED = 50.0

var player
var direction = Vector2.RIGHT
var damage = 1
var damaging = false
func _ready():
	player = get_parent().get_node("CharacterBody2D")

func _physics_process(delta):

	if player:
		direction = (player.global_position - global_position).normalized()
		global_position += SPEED * direction * delta

	if damaging:
		player.take_damage(damage)

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true


func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false
