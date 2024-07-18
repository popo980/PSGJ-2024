extends StaticBody2D

const ROCK_ITEM = preload("res://Scene/RockItem.tscn")

@onready var collision = $CollisionPolygon2D
@onready var sprite = $Sprite
@onready var particles = $Particles

func get_item():
	return ROCK_ITEM


func _on_ressources_destroy_signal():
	print("Rock destroyed")
	collision.queue_free()
	sprite.queue_free()
	particles.emitting = true
