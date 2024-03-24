extends CharacterBody2D

class_name FlyingEnemy

@export var enemy_stats: FlyingEnemyStats
@export var player: Player
@onready var nav_agent = $NavigationAgent2D

var direction = Vector2.RIGHT
var damaging = false
var in_range = false

func _ready():
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4
	if !player:
		player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(delta):
	if in_range and player:
		nav_agent.target_position = player.global_position
	
	if nav_agent.is_navigation_finished():
		return
	
	var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	velocity = direction * enemy_stats.SPEED

	if damaging:
		player.take_damage(enemy_stats.DAMAGE)

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true

func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false

func _on_range_body_entered(body):
	if body.name == "Player":
		in_range = true

func _on_range_body_exited(body):
	if body.name == "Player":
		in_range = false
