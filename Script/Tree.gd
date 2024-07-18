extends StaticBody2D

@onready var collision = $CollisionShape2D

func _on_destroy_signal():
	print("Tree destroyed")
	collision.queue_free()
