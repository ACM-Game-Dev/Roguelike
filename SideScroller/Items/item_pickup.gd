extends Area2D

@export var item: Item = null

func _on_body_entered(body):
	if body.has_method("equip_item"):
		body.equip_item(item)
		queue_free()
