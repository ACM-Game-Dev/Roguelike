extends Resource

class_name Weapon_Resource


@export var equipment_name: String

@export_group("Anims")
@export var idle_anim: String
@export var activate_anim: String
@export var throw_anim: String

@export_group("Sprites")
@export var hand_sprite: String
@export var world_sprite: String

@export_group("Statistics")
@export var damage: int
@export var attack_delay: int


