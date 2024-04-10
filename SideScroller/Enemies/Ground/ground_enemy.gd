extends CharacterBody2D

class_name GroundEnemy

@export var enemy_resource: Enemy_Resource

@onready var player: Player = Globals.get_player()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var damaging = false
var direction = Vector2.RIGHT
var distance = 100
var range = 150

func _ready():
	if !player:
		player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(delta):
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


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		damaging = true


func _on_area_2d_body_exited(body):
	if body.has_method("take_damage"):
		damaging = false
