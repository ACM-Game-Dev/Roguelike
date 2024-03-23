extends CharacterBody2D

class_name GroundEnemy

@export var player: Player
@export var enemy_stats: GroundEnemyStats

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var damaging = false
var direction = Vector2.RIGHT
var distance = 100

func _ready():
	if !player:
		player = get_parent().get_node("CharacterBody2D")

func _physics_process(delta):

	if player:
		distance = (player.global_position - global_position).length()
		
		if distance < enemy_stats.RANGE:
			direction = (player.global_position - global_position).normalized()
			global_position += enemy_stats.SPEED * direction * delta
			velocity.y += gravity * delta

	if damaging:
		player.take_damage(enemy_stats.DAMAGE)

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true


func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false
