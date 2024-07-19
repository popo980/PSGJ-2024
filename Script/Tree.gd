extends StaticBody2D

const TREE_ITEM = preload("res://Scene/TreeItem.tscn")

@onready var collision = $CollisionShape2D
@onready var particles = $Particles
@onready var sprite = $Sprite

func get_item():
	return TREE_ITEM


func _on_ressources_destroy_signal():
	print("Tree destroyed")
	collision.queue_free()
	sprite.queue_free()
	particles.emitting = true

func _on_ressources_hit_signal():
	$AudioStreamPlayer.play()
