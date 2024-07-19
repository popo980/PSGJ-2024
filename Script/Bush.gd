extends StaticBody2D

const BUSH_ITEM = preload("res://Scene/BushItem.tscn")

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite
@onready var particles = $Particles

func get_item():
	return BUSH_ITEM


func _on_ressources_destroy_signal():
	print("Bush destroyed")
	collision.queue_free()
	sprite.queue_free()
	particles.emitting = true


func _on_ressources_hit_signal():
	$AudioStreamPlayer.play()
