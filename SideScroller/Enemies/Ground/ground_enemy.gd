extends CharacterBody2D

class_name GroundEnemy

@export var player: Player
@export var enemy_stats: GroundEnemyStats

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if !player:
		player = get_parent().get_node("CharacterBody2D")

func _physics_process(delta):

	if player:
		enemy_stats.DISTANCE = (player.global_position - global_position).length()
		
		if enemy_stats.DISTANCE < enemy_stats.RANGE:
			enemy_stats.DIRECTION = (player.global_position - global_position).normalized()
			global_position += enemy_stats.SPEED * enemy_stats.DIRECTION * delta
			velocity.y += gravity * delta

	if enemy_stats.DAMAGING:
		player.take_damage(enemy_stats.DAMAGE)

	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		enemy_stats.DAMAGING = true


func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		enemy_stats.DAMAGING = false
