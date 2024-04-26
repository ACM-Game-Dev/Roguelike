extends Node2D
var SPEED = 10
var direction = Vector2.RIGHT
@onready var arrow_sprite = $Sprite2D
var damage = 5
var knockback
@onready var player: Player = Globals.player

func _process(delta):
	direction = Vector2.RIGHT.rotated(rotation)
	position.x += direction.x * SPEED 
	position.y += direction.y * SPEED 
	print("ARROW IN AIR")

func hit_enemy(body,damage):
	if knockback == null:
		body.enemy_take_damage(damage,{})
	if player and player.global_position.x < body.global_position.x:
		knockback.x *= -1
	body.enemy_take_damage(damage,{"knockback":knockback})

func _on_visible_on_screen_notifier_2d_screen_exited():
	print("ARROW DELETED")
	queue_free()


func arrow_hit(body):
	if body.name != "Player": 
		if body.has_method("enemy_take_damage"):
			body.stun_timer = .2
			hit_enemy(body,damage)
		queue_free()
	
