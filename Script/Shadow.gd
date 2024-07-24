extends Area2D

enum Mob{
	SHEEP,
	BOAR,
	BEE
}

var mob_name = ["Sheep", "Boar", "Bee"]

@export var mob : Mob
@export var mob_sprite : AnimatedSprite2D
var sprite : AnimatedSprite2D
var animation : String
var default_animation = "idle"
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	var rect_size = mob_sprite.get_sprite_frames().get_frame_texture(default_animation, 0).get_size()
	collision_shape_2d.shape.size = rect_size
	sprite = mob_sprite.duplicate()
	sprite.modulate = Color(0.1, 0.1, 0.1, 0.25)
	sprite.flip_v = true
	sprite.z_index = -1
	animation = default_animation
	add_child(sprite)

func change_animation(new_animation):
	sprite.animation = new_animation

func get_item_id_type():
	return -1

func interact(player):
	sprite.modulate = Color(0, 0, 0, 0)
	print("ombre de ", mob_name[mob], " ajoutée à l'inventaire des ombres !")
	# add shadow in player inventory
	player.add_shadow_inventory(mob)
