extends StaticBody2D

@onready var collision = $CollisionPolygon2D

func _on_destroy_signal():
	print("Rock destroyed")
	collision.queue_free()
